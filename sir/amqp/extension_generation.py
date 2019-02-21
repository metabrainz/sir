#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2019 MetaBrainz Foundation
# License: MIT, see LICENSE for details
from functools import partial
from psycopg2 import connect, sql
from sir import config
from sir.trigger_generation import write_header, write_footer
from textwrap import dedent


def generate_extension(args):
    """
    Generate an SQL file to create extension amqp.
    """
    extension_filename = args["extension_file"]

    dbcget = partial(config.CFG.get, "database")
    database_config = {key: dbcget(key) for key in
            ["dbname", "user", "password", "host", "port"]}

    rmqcget = partial(config.CFG.get, "rabbitmq")
    rabbitmq_config = [rmqcget(key) for key in
            ["host", "vhost", "user", "password"]]

    with connect(**database_config) as connection:
        sql_string = dedent(sql.SQL("""\
            CREATE EXTENSION amqp;
            ALTER SCHEMA amqp OWNER TO {owner};
            ALTER TABLE amqp.broker OWNER TO {owner};
            INSERT INTO amqp.broker (host, vhost, username, password)
                VALUES ({broker});\n
        """).format(
            owner=sql.Identifier(database_config["user"]),
            broker=sql.SQL(', ').join(map(sql.Literal, rabbitmq_config))
        ).as_string(connection))

    with open(extension_filename, "w") as f:
        write_header(f)
        f.write(sql_string)
        write_footer(f)
