local status, formatter = pcall(require, "formatter")
if not status then
  vim.notify("没有找到 formatter")
  return
end

formatter.setup({
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            -- "--config-path "
            --   .. os.getenv("XDG_CONFIG_HOME")
            --   .. "/stylua/stylua.toml",
            "-",
          },
          stdin = true,
        }
      end,
    },
    -- Configuration for gofmt
    go = {
      function()
        return {
          exe = "gofmt",
          stdin = true
        }
      end
    },
    -- Configuration for goimports
    go = {
      function()
        return {
          exe = "goimports",
          args = {"-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))},
          stdin = false
        }
      end
    },
  },
})

-- format on save
vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.lua FormatWrite
    augroup END
]],
  true
)