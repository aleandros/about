const doc = """
Find information about programs in the system's PATH

Usage:
  about <pattern> [--history | --name-only]
  about (-h | --help)
  about --version

Options:
  -h --help     Show this screen.
  --version     Show version.
  --name-only   Match only file name (ignore directory)
  --history     Search for matches in history
"""

import strutils
import docopt
import sets
import os
import osproc

let args = docopt(doc, version = "about 0.1.0")

proc isExecutable(path: string): bool =
  let permissions = getFilePermissions(path)
  fpUserExec in permissions

proc isProgram(path: string): bool =
  existsFile(path) and isExecutable(path)

proc isMatch(path: string, pattern: string, nameOnly: bool): bool =
  let against = if nameOnly:
                  let parts = path.split({'/'})
                  parts[len(parts) - 1]
                else:
                  path
  pattern in against

iterator pathElements(): string =
  for element in toSet(getEnv("PATH").split({':'})):
    for _, path in walkDir(element):
      yield path

if args["--history"]:
  let shell = getEnv("SHELL")
  let output = execProcess("$1 -c history" % [shell])
  for line in output.splitLines():
    if $args["<pattern>"] in line:
      echo line
else:
  for element in pathElements():
    if isProgram(element):
      if isMatch(element, $args["<pattern>"], args["--name-only"]):
        echo element

