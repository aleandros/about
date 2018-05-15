import unittest, aboutpkg/fileutils

suite "about util functions":
  test "baseName":
    check(baseName("/this/is/a/path") == "path")
    check(basename("raw") == "raw")
    check(baseName("hello/world") == "world")
    check(baseName("/") == "")
