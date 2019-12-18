require 'lfs' -- подключаем LuaFileSystem https://keplerproject.github.io/luafilesystem/manual.html
local param = {
	libs    = {
		{ [[\build\libs\math.lua]], 'https://raw.githubusercontent.com/nazarpunk/warcraft3-lua-lib/master/math.lua' },
		{ [[\build\libs\pathable.lua]], 'https://raw.githubusercontent.com/nazarpunk/warcraft3-lua-lib/master/pathable.lua' }
	},
	current = lfs.currentdir() -- текущая папка проэкта
}
-- подключаем нужные функции
dofile(param.current .. [[\run\lib\FileDownload.lua]])

-- скачиваем нужные файлы
for i = 1, #param.libs do
	local lib     = param.libs[i]
	local content = FileDownload(lib[2])
	local file    = io.open(param.current .. lib[1], 'w+')
	file:write(content)
	file:close()
end

-- запускаем сборку
dofile(lfs.currentdir() .. [[\run\build.lua]])