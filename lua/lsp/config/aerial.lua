local opts = {
    on_attach = function(client, bufnr)
        -- your code here
        require('aerial').on_attach(client, bufnr)
    end,
}

return {
    on_setup = function(server)
        server:setup(opts)
    end,
}
