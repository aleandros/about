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

import docopt, sets, os, osproc, strutils
import aboutpkg/fileutils

let
  args = docopt(doc, version = "about 0.1.1")
  pattern = $args["<pattern>"]
  history = args["--history"]

proc isExecutable(path: string): bool =
  let permissions = getFilePermissions(path)
  fpUserExec in permissions

proc isProgram(path: string): bool =
  existsFile(path) and isExecutable(path)

proc isMatch(path: string, pattern: string, nameOnly: bool): bool =
  let target = if nameOnly: baseName(path) else: path
  pattern in target

iterator pathElements(): string =
  for element in toSet(getEnv("PATH").split({PathSep})):
    for _, path in walkDir(element):
      yield path

iterator programs(): string =
  for element in pathElements():
    if isProgram(element):
      yield element


if history:
  let
    shell = getEnv("SHELL")
    output = execProcess("$1 -c history" % [shell])
  for line in output.splitLines():
    if pattern in line:
      echo line
else:
  for program in programs():
    if isMatch(program, pattern, args["--name-only"]):
        echo program
