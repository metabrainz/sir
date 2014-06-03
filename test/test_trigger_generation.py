import mock
import unittest

from . import models
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
        "SELECT id FROM table_b WHERE c = ({new_or_old}.id)")
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
        self.assertEqual(result.render(),
        "SELECT id FROM table_c WHERE id IN ({new_or_old}.c)")
        self.assertEqual(table, "table_b")

    def test_one_to_many_column_returns_none(self):
        path = "bs.id"
        model = models.C
        result, table = walk_path(model, path)
        self.assertTrue(result is None)
        self.assertTrue(table is None)


class TriggerGeneratorTest(unittest.TestCase):
    class TestGenerator(TriggerGenerator):
        id_replacement = "REPLACEMENT"
        op = "OPERATION"
        beforeafter = "SOMEWHEN"

    def setUp(self):
        self.gen = self.TestGenerator("PREFIX", "TABLE", "foo.bar", "SELECTION")

    def test_function(self):
        self.assertEqual(self.gen.function,
"""
CREATE OR REPLACE FUNCTION {name}() RETURNS trigger
    AS $$
BEGIN
    FOR row IN SELECTION LOOP
        PERFORM amqp.publish(1, EXCHANGE, ROUTING_KEY, row.id);
    END LOOP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
""".format(name=self.gen.triggername)
                        )

    def test_triggername(self):
        self.assertEqual(self.gen.triggername,
                         "search_PREFIX_OPERATION_foo_bar")

    def test_trigger(self):
        self.assertEqual(self.gen.trigger,
                         "\n"
                         "CREATE TRIGGER {name} SOMEWHEN OPERATION ON TABLE"
                         "\n"
                         "    FOR EACH ROW EXECUTE PROCEDURE {name}();"
                         "\n".
                         format(name=self.gen.triggername))

    def test_delete_attributes(self):
        self.assertEqual(DeleteTriggerGenerator.op, "delete")
        self.assertEqual(DeleteTriggerGenerator.id_replacement, "OLD")
        self.assertEqual(DeleteTriggerGenerator.beforeafter, "BEFORE")

    def test_insert_attributes(self):
        self.assertEqual(InsertTriggerGenerator.op, "insert")
        self.assertEqual(InsertTriggerGenerator.id_replacement, "NEW")
        self.assertEqual(InsertTriggerGenerator.beforeafter, "AFTER")

    def test_update_attributes(self):
        self.assertEqual(UpdateTriggerGenerator.op, "update")
        self.assertEqual(UpdateTriggerGenerator.id_replacement, "NEW")
        self.assertEqual(UpdateTriggerGenerator.beforeafter, "AFTER")


class WriteTriggersTest(unittest.TestCase):
    def setUp(self):
        self.triggerfile = mock.Mock()
        write_triggers_to_file(self.triggerfile, (InsertTriggerGenerator,),
                               "entity_c", "table_c", "bs.foo", "SELECTION")
        self.gen = InsertTriggerGenerator("entity_c", "table_c", "bs.foo",
                                          "SELECTION")

    def test_writes_function(self):
        self.triggerfile.write.assert_any_call(self.gen.function)

    def test_writes_trigger(self):
        self.triggerfile.write.assert_any_call(self.gen.trigger)

    def test_write_count(self):
        self.assertEqual(self.triggerfile.write.call_count, 2)


class DirectTriggerWriterTest(unittest.TestCase):
    def setUp(self):
        self.triggerfile = mock.Mock()
        write_direct_triggers(self.triggerfile, "entity_c", models.C)
        self.generators = []
        for g in (GIDDeleteTriggerGenerator,
                  InsertTriggerGenerator,
                  UpdateTriggerGenerator):
            gen = g("entity_c", "table_c", "direct",
                    "SELECT id FROM table_c WHERE id = {new_or_old}.id")
            self.generators.append(gen)

    def test_writes_functions(self):
        for gen in self.generators:
            self.triggerfile.write.assert_any_call(gen.function)

    def test_writes_triggers(self):
        for gen in self.generators:
            self.triggerfile.write.assert_any_call(gen.trigger)

    def test_write_count(self):
        self.assertEqual(self.triggerfile.write.call_count, 6)
