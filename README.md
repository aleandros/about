# about - Command line tool for finding information about programs

This is a simple tool for finding information about executables found
in your PATH.

While useful, it was also my example project for learning [nim](https://nim-lang.org/)
which is an amazing, super easy to use, fast language.


## Building

Compile with:

```
$ nimble build
```

You can then copy it to your path and you're set.

## Running

Execute `about` to see the documentation. But you can expect something similar to this:

```
$ about python
```
Output:
```
/usr/bin/python
/usr/bin/python2.7
```

Options were added for searching history and not matching directory names. 


## Future work?

I'm thinking about:

* Stats of program usage
* Inspect process information given the name of the program
* Support for regular expressions
