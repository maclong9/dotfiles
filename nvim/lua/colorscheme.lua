if vim.loop.os_uname().sysname == "Darwin" then
	vim.cmd("colorscheme oxocarbon")
elseif vim.loop.os_uname().sysname == "OpenBSD" then
	vim.cmd("colorscheme everforest")
elseif vim.loop.os_uname().sysname == "Linux" then
	vim.g.gruvbox_material_background = "medium"
	vim.g.gruvbox_material_transparent_background = 1
	vim.cmd("colorscheme gruvbox-material")
else
	vim.cmd("colorscheme default")
end
