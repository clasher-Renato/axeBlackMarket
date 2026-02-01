fx_version("cerulean")
game("gta5")
lua54("yes")
author("AXE Scripts")
description("BlackMarket Script")
version("1.0.0")

shared_scripts({
	"config.lua",
})

client_scripts({
	"client/cl-utils.lua",
	"client/cl-main.lua",
})

server_scripts({
	"server/sv-main.lua",
})
