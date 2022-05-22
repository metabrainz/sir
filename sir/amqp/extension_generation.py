#!/usr/bin/env python
# coding: utf-8
# Copyright (c) 2019 MetaBrainz Foundation
# License: MIT, see LICENSE for details
from functools import partial
from psycopg2 import connect, sql
from sir import config
from sir.trigger_generation import write_header, write_footer
from textwrap import dedent
import os
import stat


def generate_extension(args):
    """
    Generate an SQL file to create extension amqp.
    """
    extension_filename = args["extension_file"]
    wrapper_filename = args["wrapper_file"]

    dbcget = partial(config.CFG.get, "database")
    database_config = {key: dbcget(key) for key in
            ["dbname", "user", "password", "host", "port"]}
    
    with open(wrapper_filename, "w") as f:
        f.write("#!/bin/bash\n")
        psql_string = "PGPASSWORD={password} psql -h {host} -p {port} -U {user} -d {dbname} \"$@\"\n".format(
            host=database_config["host"],
            port=database_config["port"],
            user=database_config["user"],
            password=database_config["password"],
            dbname=database_config["dbname"])
        f.write(psql_string)
    
    st = os.stat(wrapper_filename)
    os.chmod(wrapper_filename, st.st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

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
