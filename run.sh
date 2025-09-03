#!/bin/sh

if ! [ -x "$(command -v luajit)" ]; then
  echo -n "LuaJit is not installed or not in PATH."
  exit 1
fi

luajit ./main.lua
