local g = vim.g
if g.colors_name ~= nil then
    vim.api.nvim_command 'highlight clear'
end

require("yoru").setup({
    transparency = false,
})
