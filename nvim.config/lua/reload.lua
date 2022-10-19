function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^plugins') or
        name:match('^keymaps') or
        name:match('^settings') or
        name:match('^reload') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
