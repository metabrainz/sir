===============================
enumerate_skip
===============================

This package provides 2 iterators, `enumerate_skip` and `enumerate_manual`, that
extend the behaviour of the standard libraries `enumerate` a bit.

`enumerate_skip` has been extended with a `skip` method that makes sure the next
`index` yielded is the same as the current one. The word `skip` might not make
sense at first, but this function was written because I needed to not handle
some values yielded by an iterator, like::

  for index, obj in enumerate(...):
      if obj.has_some_attr():
          continue
      # do something with object and index here

If `index` in that example was printed to the user (or something similar), there
would be gaps. Using `enumerate_skip` instead, the above example could be
written as::

  it = enumerate_skip(...)
  for index, obj in it:
      if obj.has_some_attr():
          it.skip()
          continue
      # do something with object and index here

`enumerate_manual` works the other way around: you have to manually call
`advance` on it to increment the `index`::

  it = enumerate_manual(...)
  for index, obj in it:
      if obj.has_some_attr():
          continue
      # do something with object and index here
      it.advance()


