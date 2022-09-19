# where should we download your Zsh plugins?
ZPLUGINDIR=$HOME/.config/zsh/plugins

# declare a simple plugin-load function
function plugin-load {
  local repo plugdir initfile
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules https://kgithub.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      local -a initfiles=($plugdir/*.plugin.{z,}sh(N) $plugdir/*.{z,}sh{-theme,}(N))
      (( $#initfiles )) || { echo >&2 "No init file found '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugdir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# make a github repo plugins list
plugins=(
  zrut747/alp
  jeffreytse/zsh-vi-mode

  # load these at hypersonic load speeds with zsh-defer
  romkatv/zsh-defer
  rupa/z
  peterhurford/up.zsh
  zsh-users/zsh-autosuggestions
  zdharma-continuum/fast-syntax-highlighting
)
plugin-load $plugins

# change the escape key to `jj` in insert mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
