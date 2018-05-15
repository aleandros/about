import strutils

proc baseName*(path: string): string =
  let parts = path.split({'/'})
  parts[len(parts) - 1]
