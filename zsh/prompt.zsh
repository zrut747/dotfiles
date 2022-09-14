# print prompt with colors
autoload -U colors && colors

function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo
    fi
}

local ret_status="%(?,%{$terminfo[bold]$fg[green]%}➜ ,%{$terminfo[bold]$fg[red]%}➜ "

PROMPT="%(#,%{$fg[red]%}%n,%{$fg[cyan]%}%n) \
%{$reset_color%}at %{$fg[magenta]%}%M \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}
${ret_status}%{$reset_color%} \
"