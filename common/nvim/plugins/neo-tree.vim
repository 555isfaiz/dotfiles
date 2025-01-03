lua << END
-- vim.api.nvim_create_augroup("neotree", {})
-- vim.api.nvim_create_autocmd("VimEnter", {
--   desc = "Open Neotree automatically",
--   group = "neotree",
--   callback = function()
--     -- if vim.fn.argc() == 0 and not vim.fn.exists "s:std_in" then
--       vim.cmd "Neotree"
--     -- end
--   end,
-- })

require("which-key").add({
    {"<space>nt", "<Cmd>Neotree toggle<CR>", desc = "Neotree: toggle on the side"},
    {"<F2>", "<Cmd>Neotree filesystem reveal float<CR>", desc = "Neotree: toggle floating window"}
})

END

nmap <silent>    <F2> <Cmd>Neotree toggle<CR>
