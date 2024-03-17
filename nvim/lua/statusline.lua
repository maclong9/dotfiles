-- [[ Statusline ]]
local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint#󰌵 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation#󰋼 " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. ""
end

local function lineinfo()
	return " %l:%c "
end

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		filename(),
		"%#Normal# ",
		lsp(),
		"%=%#StatusLineExtra#",
		lineinfo(),
	})
end

vim.api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active() | setlocal tabstop=4 shiftwidth=4
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short() | setlocal tabstop=4 shiftwidth=4
  augroup END
]],
	false
)

vim.cmd("highlight StatusLine   cterm=NONE ctermfg=white ctermbg=NONE guifg=white guibg=NONE")
vim.cmd("highlight StatusLineNC cterm=NONE ctermfg=white ctermbg=NONE guifg=white guibg=NONE")
