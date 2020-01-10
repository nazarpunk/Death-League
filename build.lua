local pack = require 'cheapack'

pack.build(
		[[D:\Games\Warcraft III\x86_64]],
		[[C:\Users\nazarpunk\IdeaProjects\Death-League]],
		'map.w3x',
		{
			--'src\\lib',
			--'src\\global',
			--'src\\ability',
			--'src\\hero',
			'src\\init.lua'
		},
		'editor'
)