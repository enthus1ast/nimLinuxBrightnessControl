
const kernel = "/sys/class/backlight/nv_backlight/brightness"
const maxval = 100
# const minval = 1
import strutils

proc get(): int = 
  # echo repr readFile(kernel)
  return parseInt( $(readFile(kernel)).strip() )

proc set(val: int) = 
  if val > maxval:
    writeFile(kernel, $maxval)
  else:
    writeFile(kernel, $val)


when isMainModule:
  import os

  if paramCount() != 1:
    echo """
  Usage:
    sbl +10 # increase light
    sbl -10 # decrease light
    sbl 50  # set light

    prepare sbl with "chmod +s sbl"
"""    
    quit()

  var rawParam = $paramStr(1).strip()
  var changer = rawParam.parseInt()
  if rawParam.startsWith("-") or rawParam.startsWith("+"):
    set( get()+changer ) 
  else:
    set( changer )
