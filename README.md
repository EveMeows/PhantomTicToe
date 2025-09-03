# Phantom TicTacToe

A tiny Phantom TicTacToe implementation in LuaJIT in the terminal!

> [!NOTE]
> This literally took 1 file and 200 lines lmao

# Showcase
![show](./repo/showcase.png)

# How to play?
## Gameplay
When you open the game, you'll see \<player>'s turn, with a > prompt.

You can either type an `index` (the numbers on the board) or a command.

Available commands are
- clear, cls -> clears the screen
- reset -> resets the game
- q, quit -> quits the game

## Game rules
Phantom TicTacToe is almost identical to the regular TicTacToe, the only difference is, there can only be 3 (three) marks on the board at a time. Once there are more, the first mark placed will dissapear!

# Building and installation
The game is written entirely in LuaJIT, so running is super easy.

First, we have to install LuaJIT and it's dependencies.
```bash
# Windows 10/11
winget install Git.Git DEVCOM.LuaJIT

# Ubuntu/Fedora
sudo apt/dnf install luajit git

# Arch/Manjaro
sudo pacman -S luajit git
```
<br>
Now, we can clone the repository and run the game.

```bash
git clone https://github.com/EveMeows/phantomTicTacToe
cd phantomTicTacToe

luajit ./main.lua
```

# Installing
If you want something more, like an executable you can use srlua to create it.

```bash
git clone https://github.com/LuaDist/srlua
cd srlua

# On windows, you must have VS2022 installed with the C/C++ tools, and open a developer powershell instance.

gcc -o srlua srlua.c -lluajit
gcc -o glue glue.c

# Now, you can create the executable
# Leave out the .exe if on linux.
./glue srlua ./main.lua ./phantom.exe
```

# License
GPL 3

