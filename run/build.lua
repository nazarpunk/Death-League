require 'lfs'
local param = {
	game    = [[D:\Games\Warcraft III\x86_64]], -- папка с игрой
	map     = [[\map.w3x]], -- папка с картой
	output  = [[\custom-code.lua]], -- файл, в который собирается весь код
	patcher = [[\custom-code-replacer.exe]], -- патчер для .wct
	lib     = [[\run\lib]], -- папка с нужными для сборки функциями
	files   = { -- порядок сборки файлов
		[[\build\Ability]],
		[[\build\Libs]],
		[[\build\Init.lua]],
	},
	tag     = [[--CUSTOM_CODE]], -- тэг для вставки кода
	current = lfs.currentdir() -- текущая папка проэкта
}

-- подключаем нужные функции
for file in lfs.dir(param.current .. param.lib) do
	if lfs.attributes(file, 'mode') ~= 'directory' then
		dofile(param.current .. param.lib .. '\\' .. file)
	end
end

-- собираем всё в один файл
local output = io.open(param.current .. param.output, 'w+')
output:write(param.tag, '\n')
for i = 1, #param.files do
	local file = param.files[i]
	local path = param.current .. file
	if file:match "[^.]+$" == 'lua' then
		output:write(FileContent(path), '\n')
	else
		for filepath, attr in DirTree(path) do
			if (attr.mode == 'file') then
				output:write(FileContent(filepath), '\n')
			end
		end
	end
end

output:write(param.tag)
output:close()

-- заменяем код в war3map.lua
local path    = param.current .. param.map .. '\\war3map.lua'
local war3map = io.open(path, 'r')
output        = io.open(param.current .. param.output, 'r')
local content = war3map:read('*a')
war3map:close()
war3map           = io.open(path, 'w+')
local repl, count = string.gsub(content, param.tag .. '.*' .. param.tag, output:read('*a'))
war3map:write(repl)
war3map:close()
output:close()

-- патчим .wct
os.execute('start "" "' .. param.current .. param.patcher .. '" "' .. param.current .. param.map .. '\\war3map.wct" "' .. param.current .. param.output .. '"')

-- запускаем игру
if type(IsRunGame) == 'boolean' then
	os.execute('start  "" "' .. param.game .. '\\' .. 'Warcraft III.exe" -loadfile "' .. param.current .. '\\' .. param.map .. '"')
end

-- запускаем редактор
if type(IsRunEditor) == 'boolean' then
	os.execute('start  "" "' .. param.game .. '\\' .. 'World Editor.exe" -loadfile "' .. param.current .. '\\' .. param.map .. '"')
end