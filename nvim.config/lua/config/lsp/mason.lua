require("mason").setup({
  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "single",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
