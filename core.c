#include "main_lua.h"

#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

int main() {
  lua_State *L = luaL_newstate();
  luaL_openlibs(L);

  // Cast unsigned char* to const char* for luaL_dostring
  if (luaL_dostring(L, (const char*)main_lua) != LUA_OK) {
    const char *err = lua_tostring(L, -1);
    printf("Lua error: %s\n", err);
    lua_pop(L, 1);
  }

  lua_close(L);
  return 0;
}
