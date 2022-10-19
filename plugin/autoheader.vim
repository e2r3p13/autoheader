" Title:        autoheader
" Description:  Generates headers with :ahr command, and updates
"				it on save it present
" Last Change:  19/10/2022
" Maintainer:   Example User <https://github.com/lfalkau>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_autoheader")
    finish
endif
let g:loaded_autoheader = 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/autoheader/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 AddHeader lua require("autoheader").AddHeader()
command! -nargs=0 UpdHeader lua require("autoheader").UpdHeader()
