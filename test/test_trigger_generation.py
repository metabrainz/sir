import doctest
import mock
import unittest
import textwrap

from test import models
from sir.trigger_generation import (unique_split_paths,
                                    walk_path,
                                    OneToManyPathPart,
                                    ManyToOnePathPart,
                                    ColumnPathPart,
                                    TriggerGenerator,
                                    DeleteTriggerGenerator,
                                    InsertTriggerGenerator,
                                    UpdateTriggerGenerator,
                                    GIDDeleteTriggerGenerator,
                                    write_triggers_to_file,
                                    write_direct_triggers)


class UniqueSplitPathsTest(unittest.TestCase):
    def run_test(self, paths, expected):
        res = list(unique_split_paths(paths))
        self.assertEqual(res, expected)

    def test_not_dotted_paths(self):
        paths = ["a", "b"]
        expected = ["a", "b"]
        self.run_test(paths, expected)

    def test_dotted_paths(self):
        paths = ["a.b.c", "e.f"]
        expected = [
            "a", "a.b", "a.b.c",
            "e", "e.f",
        ]

        self.run_test(paths, expected)

    def test_unique_paths(self):
        paths = ["a.b.c", "a.b.d"]
        expected = [
            "a", "a.b", "a.b.c",
            "a.b.d"
        ]

        self.run_test(paths, expected)


class WalkPathTest(unittest.TestCase):
    def test_many_to_one(self):
        path = "c"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, ManyToOnePathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(result.render(),
        "SELECT table_b.id FROM table_b WHERE table_b.c IN ({new_or_old}.id)")
        self.assertEqual(table, "table_c")

    def test_many_to_one_column_returns_none(self):
        path = "c.id"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_one_to_many(self):
        path = "bs"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(isinstance(result, OneToManyPathPart))
        self.assertTrue(isinstance(result.inner, ColumnPathPart))
        self.assertEqual(
            result.render(),
            "SELECT table_c.id FROM table_c WHERE table_c.id IN ({new_or_old}.c)",
        )
        self.assertEqual(table, "table_b")

    def test_one_to_many_column_returns_none(self):
        path = "bs.id"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_composite_column_returns_none(self):
        path = "composite_column"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)

    def test_non_sqlalchemy_paths(self):
        path = "c.__tablename__"
        model = models.B
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)


class TriggerGeneratorTest(unittest.TestCase):
    class TestGenerator(TriggerGenerator):
        id_replacement = "REPLACEMENT"
        op = "OPERATION"
        before_or_after = "SOMEWHEN"

    def setUp(self):
        self.path = "foo.bar"
        self.index = 7
        self.gen = self.TestGenerator("PREFIX", "TABLE", self.path,
                                      "SELECTION", "INDEXTABLE", self.index)

    def test_function(self):
        self.assertEqual(self.gen.function, textwrap.dedent("""\
            CREATE OR REPLACE FUNCTION {name}() RETURNS trigger
                AS $$
            DECLARE
                ids TEXT;
            BEGIN
                SELECT string_agg(tmp.id::text, ' ') INTO ids FROM (SELECTION) AS tmp;
                PERFORM amqp.publish(1, 'search', 'None', 'INDEXTABLE ' || ids);
                RETURN NULL;
            END;
            $$ LANGUAGE plpgsql;
            COMMENT ON FUNCTION {name}() IS 'The path for this function is {path}';\n
        """).format(name=self.gen.trigger_name, path=self.path))

    def test_triggername(self):
        self.assertEqual(self.gen.trigger_name,
                         "search_PREFIX_OPERATION_{index}".format(index=self.index))  # noqa

    def test_trigger(self):
        self.assertEqual(self.gen.trigger, textwrap.dedent("""\
             CREATE TRIGGER {name} SOMEWHEN OPERATION ON TABLE
                 FOR EACH ROW EXECUTE PROCEDURE {name}();
             COMMENT ON TRIGGER {name} ON {tablename} IS 'The path for this trigger is {path}';\n
        """).format(name=self.gen.trigger_name, path=self.path, tablename="TABLE"))

    def test_delete_attributes(self):
        self.assertEqual(DeleteTriggerGenerator.op, "delete")
        self.assertEqual(DeleteTriggerGenerator.id_replacement, "OLD")
        self.assertEqual(DeleteTriggerGenerator.before_or_after, "BEFORE")
        self.assertEqual(DeleteTriggerGenerator.routing_key, "update")

    def test_insert_attributes(self):
        self.assertEqual(InsertTriggerGenerator.op, "insert")
        self.assertEqual(InsertTriggerGenerator.id_replacement, "NEW")
        self.assertEqual(InsertTriggerGenerator.before_or_after, "AFTER")
        self.assertEqual(InsertTriggerGenerator.routing_key, "index")

    def test_update_attributes(self):
        self.assertEqual(UpdateTriggerGenerator.op, "update")
        self.assertEqual(UpdateTriggerGenerator.id_replacement, "NEW")
        self.assertEqual(UpdateTriggerGenerator.before_or_after, "AFTER")
        self.assertEqual(UpdateTriggerGenerator.routing_key, "update")


class WriteTriggersTest(unittest.TestCase):
    def setUp(self):
        self.function_file = mock.Mock()
        self.trigger_file = mock.Mock()
        self.index = 5
        write_triggers_to_file(
            trigger_file=self.trigger_file,
            function_file=self.function_file,
            generators={InsertTriggerGenerator},
            prefix="entity_c",
            table_name="table_c",
            path="bs.foo",
            select="SELECTION",
            index_table="table_b",
            index=self.index,
            broker_id=1,
        )

        self.gen = InsertTriggerGenerator("entity_c", "table_c", "bs.foo",
                                          "SELECTION", "table_b", self.index)

    def test_writes_function(self):
        self.function_file.write.assert_any_call(self.gen.function)

    def test_writes_trigger(self):
        self.trigger_file.write.assert_any_call(self.gen.trigger)

    def test_write_count(self):
        self.assertEqual(self.function_file.write.call_count, 1)
        self.assertEqual(self.trigger_file.write.call_count, 1)


class DirectTriggerWriterTest(unittest.TestCase):
    def setUp(self):
        self.functionfile = mock.Mock()
        self.triggerfile = mock.Mock()
        write_direct_triggers(
            trigger_file=self.triggerfile,
            function_file=self.functionfile,
            entity_name="entity_c",
            model=models.C,
            broker_id=1,
        )
        self.generators = []
        for g in (GIDDeleteTriggerGenerator,
                  InsertTriggerGenerator,
                  UpdateTriggerGenerator):
            gen = g("entity_c", "table_c", "direct",
                    "SELECT table_c.id FROM table_c WHERE table_c.id = "
                    "{new_or_old}.id", "table_c", 0)
            self.generators.append(gen)

    def test_writes_functions(self):
        for gen in self.generators:
            self.functionfile.write.assert_any_call(gen.function)

    def test_writes_triggers(self):
        for gen in self.generators:
            self.triggerfile.write.assert_any_call(gen.trigger)

    def test_write_count(self):
        self.assertEqual(self.functionfile.write.call_count, 3)
        self.assertEqual(self.triggerfile.write.call_count, 3)


def load_tests(loader, tests, ignore):
    from sir import trigger_generation
    tests.addTests(doctest.DocTestSuite(trigger_generation.types))
    return tests
