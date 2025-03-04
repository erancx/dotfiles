local M = {}

--- Toggle BasedPyright typeCheckingMode and inlay hints
function M.toggle_basedpyright_settings()
  -- Get the LSP client for basedpyright
  local client = vim.lsp.get_clients({ name = "basedpyright" })[1]
  if not client then
    vim.notify("BasedPyright LSP is not active", vim.log.levels.WARN)
    return
  end

  -- Toggle the typeCheckingMode
  local analysis = client.config.settings.basedpyright.analysis
  if analysis.typeCheckingMode == "basic" then
    analysis.typeCheckingMode = "recommended"
  else
    analysis.typeCheckingMode = "basic"
  end

  -- Toggle the inlayHints settings
  local hints = analysis.inlayHints
  if hints == nil then
    hints = { variableTypes = false, functionReturnTypes = false, callArgumentNames = false }
    analysis.inlayHints = hints
  end

  -- Restart the LSP to apply changes
  vim.lsp.stop_client(client.id)
  vim.defer_fn(function()
    vim.cmd("LspStart basedpyright")
    vim.notify(
      "BasedPyright restarted with typeCheckingMode: "
        .. analysis.typeCheckingMode
        .. "\nInlay Hints: "
        .. (hints.variableTypes and "enabled" or "disabled")
    )
  end, 100)
end

return M
