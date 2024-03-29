local M = {}
local util = require("yoru.util")

vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "yoru" },
    group = vim.api.nvim_create_augroup("yoru", { clear = true }),
    callback = function()
        if vim.fn.has("lualine") == 1 then
            require("lualine").setup({ options = { theme = require("yoru.lualine") } })
        end
        vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
            pattern = { "*" },
            once = true,
            callback = function()
                vim.api.nvim_command 'highlight clear'
                if vim.fn.has("lualine") == 1 then
                    require('lualine').setup({ options = { theme = "auto" } })
                end
            end
        })
    end
})


function M.setup(opts)
    local config = {
        transparency = false,
    }

    config = util.merge_tbl(config, opts)

    local colors = util.get_colors()
    if not colors then
        return
    end

    -- term hls
    util.set_hls()

    -- get hls
    local hls = util.get_hls(config.transparency)

    -- actually highlight stuff
    for hl, col in pairs(hls) do
        vim.api.nvim_set_hl(0, hl, col)
    end

    local polish = util.get_polish()
    if polish ~= nil then
        for hl, col in pairs(polish) do
            vim.api.nvim_set_hl(0, hl, col)
        end
    end
    vim.g.colors_name = "yoru"
    if vim.fn.has("lualine") == 1 then
        require("lualine").setup({ options = { theme = require("yoru.lualine") } })
    end
    vim.cmd("doautocmd User yoru")
end

return M
