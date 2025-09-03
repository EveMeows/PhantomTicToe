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
  return fmt(data[start], start) .. ' ' .. sep .. ' ' .. fmt(data[start + 1], start + 1) .. ' ' .. sep .. ' ' .. fmt(data[start + 2], start + 2)
end

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
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
  x = 'x',
  o = 'o'
}

local globals = {}
local function initGlobals()
  globals = {
    running = true,

    turn = __turns.x,
    turnCount = 1,
    board = {
      ' ', ' ', ' ',
      ' ', ' ', ' ',
      ' ', ' ', ' '
    },

    err = nil
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

  print('Phantom TicTacToe! (turn ' .. globals.turnCount .. ')\n')

  if globals.err then
    print('ERR: ' .. globals.err .. '\n')
  end

  -- Draw board
  print(makeLine(globals.board, 1))
  print(line)
  print(makeLine(globals.board, 4))
  print(line)
  print(makeLine(globals.board, 7))

  -- Derp
  print()

  -- Prompt
  io.write(globals.turn .. "'s turn!\n")
  io.write('> ')

  local query = io.read()

  -- First, check if query is a command
  local cmd = commands[trim(query)]
  if cmd then
    cmd()
    goto continue
  end

  -- Handle board
  local idx = tonumber(trim(query))
  if idx == nil then
    globals.err = 'Index or Command is invalid.'
    goto continue
  end

  local space = globals.board[idx]
  if space == nil or space ~= ' ' then
    globals.err = 'Space does not exist or is already occupied.'
    goto continue
  end

  globals.board[idx] = globals.turn

  -- Change turn
  globals.turn = globals.turn == __turns.x and __turns.o or __turns.x
  globals.turnCount = globals.turnCount + 1

  globals.err = nil
  ::continue::
end
