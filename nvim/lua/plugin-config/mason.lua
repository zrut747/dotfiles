local github_mirror = os.getenv("DOT_GITHUB_MIRROR") or "https://github.com"
require("mason").setup({
  github = {
    -- download_url_template = "https://kgithub.com/%s/releases/download/%s/%s",
    download_url_template = github_mirror.."/%s/releases/download/%s/%s",
  }
})
