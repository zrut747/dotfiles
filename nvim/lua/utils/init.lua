local M = {}

function M.merge(...)
  return vim.tbl_deep_extend("force", ...)
end

function M.github_mirror()
  local mirror = os.getenv("DOT_GITHUB_MIRROR")
  if mirror == nil or mirror == '' then
    return 'github.com'
  else
    return mirror
  end
end

return M
