local pack     = require 'cheapack'

local username = os.getenv('USERNAME')
local config   = {
	nazarpunk = {
		[[D:\Games\Warcraft III\x86_64]],
		[[C:\Users\nazarpunk\IdeaProjects\Death-League]]
	}
}
local param    = config[username]

pack.build(
		param[1],
		param[2],
		'map.w3x',
		{
			--'src\\lib',
			--'src\\global',
			--'src\\ability',
			--'src\\hero',
			--'src\\init.lua'
		},
		'editor'
)