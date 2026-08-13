-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- VSCode처럼 커서를 올려두면 자동으로 호버 문서 표시 (updatetime 이후 발동)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("auto_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not (client and client:supports_method("textDocument/hover")) then
      return
    end
    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("auto_hover_" .. args.buf, { clear = true }),
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.hover({ border = "rounded" })
      end,
    })
  end,
})
