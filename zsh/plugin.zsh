# declare a simple plugin-load function
function plugin-load() {
  local repo plugin_name plugin_dir initfile initfiles
  ZPLUGINDIR=~/.config/zsh/plugins
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://kgithub.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -s "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# make a github repo plugins list
plugins=(
  zrut747/alp

  # load these at hypersonic load speeds with zsh-defer
  romkatv/zsh-defer
  rupa/z
  jeffreytse/zsh-vi-mode
  peterhurford/up.zsh
  zsh-users/zsh-autosuggestions
  zdharma-continuum/fast-syntax-highlighting
)
plugin-load $plugins

# change the escape key to `jj` in insert mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
