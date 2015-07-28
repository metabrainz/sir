#!/usr/bin/env python
# coding: utf-8
# Copyright © 2015 Wieland Hoffmann
# License: MIT, see LICENSE for details
import ast
from collections import defaultdict, namedtuple

with open("../sir/wscompat/convert.py") as f:
    data = f.read()

parsed = ast.parse(data)


callinfo = namedtuple("callinfo", ["func", "args"])


class DocVisitor(ast.NodeVisitor):
    def __init__(self, *args, **kwargs):
        super(DocVisitor, self).__init__(*args, **kwargs)
        self.level = 0
        #: A list of already known functions defined in this module
        self.known_funcs = []
        #: Maps object names to functions called on them in the form of callinfo
        # objects
        self.funcs_for_obj = defaultdict(list)

    def make_output(self):
        # Only do this if we already know some functions, or, in other words,
        # only after the first complete function definition
        if len(self.known_funcs):
            print("=={}==".format(self.known_funcs[-1]))
            for obj, funcs in self.funcs_for_obj.items():
                print("==={}===".format(obj))
                for f in funcs:
                    if not len(f.args):
                        print("* {}".format(f.func))
                    else:
                        print("* {} ({})".
                                            format(f.func,
                                                   ", ".join("[[#{}]]". format(name) for name in f.args)))  # noqa
        self.funcs_for_obj.clear()

    def visit_FunctionDef(self, node):
        self.make_output()
        self.known_funcs.append(node.name)
        self.generic_visit(node)

    def visit_Call(self, node):
        if isinstance(node.func, ast.Attribute):
            # A function is called on an object
            f = node.func
            if f.value.id == "models":
                # This just means that a new object is created
                return
            self.funcs_for_obj[f.value.id].append(callinfo(f.attr, []))
            for arg in node.args:
                self.visit_CallAsArg(f.value.id, arg)

    def visit_CallAsArg(self, objname, node):
        if not isinstance(node, ast.Call):
            return

        if (isinstance(node.func, ast.Name)):
            # The return value of a function we already know about is used as an
            # argument to another function called on an object - note that in
            # the callinfo object so we can later create a link
            if node.func.id in self.known_funcs:
                self.funcs_for_obj[objname][-1].args.append(node.func.id)


v = DocVisitor()
v.visit(parsed)
v.make_output()
