-- Sowwy normal lua users :C
if not jit then
  print('We are sorry! :(')
  print('This program is only designed to run with LuaJIT!')
  print('Please install LuaJIT and run the program again.')
  print('NOTE: This is the case because regular lua does NOT offer a way to fetch OS.')

  os.exit(1)
end

-- @region fields
local function clear()
  if jit.os == "Windows" then
    os.execute('cls')
    return
  end

  os.execute('clear')
end

local line = '---------'
local sep  = '|'

local function fmt(str, num)
  return str == ' ' and num or str
end

local function makeLine(data, start)
  return fmt(data[1], start) .. ' ' .. sep .. ' ' .. fmt(data[2], start + 1) .. ' ' .. sep .. ' ' .. fmt(data[3], start + 2)
end

local commands = {}
local function pushCommand(name, callback)
  if type(name) == 'table' then
    for _, entry in pairs(name) do
      commands[entry] = callback
    end

    return
  end

  commands[name] = callback
end

local __turns = {
  x = 'X',
  o = 'O'
}

local globals = {}
local function initGlobals()
  globals = {
    running = true,

    turn = __turns.x,
    board = {
      {' ', ' ', ' '},
      {' ', ' ', ' '},
      {' ', ' ', ' '}
    }
  }
end
-- @region fields

initGlobals()

pushCommand({'quit', 'q'}, function()
  globals.running = false
end)

pushCommand('reset', function()
  initGlobals()
end)

pushCommand({'clear', 'cls'}, function()
  clear()
end)

while globals.running do
  clear()

  -- Draw board
  print(makeLine(globals.board[1], 1))
  print(line)
  print(makeLine(globals.board[2], 4))
  print(line)
  print(makeLine(globals.board[3], 7))

  -- Derp
  print()

  -- Prompt
  io.write(globals.turn .. "'s turn!\n")
  io.write('> ')

  local query = io.read()

  -- First, check if query is a command
  local cmd = commands[query]
  if cmd then
    cmd()
    goto continue
  end

  -- TODO: query is a number

  -- Change turn
  globals.turn = globals.turn == __turns.x and __turns.o or __turns.x

  ::continue::
end
