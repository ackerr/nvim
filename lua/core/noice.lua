-- notice.nvim
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

local search = vim.api.nvim_get_hl_by_name("Search", true)
vim.api.nvim_set_hl(0, "TransparentSearch", { fg = search.foreground })

local help = vim.api.nvim_get_hl_by_name("IncSearch", true)
vim.api.nvim_set_hl(0, "TransparentHelp", { fg = help.foreground })

local cmdGroup = "DevIconLua"
local noice_cmd_types = {
  CmdLine = cmdGroup,
  Input = cmdGroup,
  Lua = cmdGroup,
  Filter = cmdGroup,
  Rename = cmdGroup,
  Substitute = "Define",
  Help = "TransparentHelp",
  Search = "TransparentSearch",
}

for type, hl in pairs(noice_cmd_types) do
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon" .. type, { link = hl })
end
vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = cmdGroup })
