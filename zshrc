if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH=$HOME/.oh-my-zsh
plugins=(git docker macos common-aliases virtualenv kubectl terraform)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GOPATH=$HOME/workspace/go
export EDITOR=${EDITOR:-nvim}
export LESS=-Ri
export KUBE_EDITOR="nvim"
export PATH=$PATH:$HOME/workspace/venv/default/bin/:/usr/local/bin:$GOPATH/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'


alias ls='gls --color=auto'
alias vim="nvim"
alias vimdiff="nvim -d"
alias vi=nvim
alias rm='rm -i'
alias cp='cp -i'
alias mv="mv -i"
alias less="bat --theme=TwoDark"
alias cat="bat --theme=TwoDark"
alias vimrc="$EDITOR ~/.vimrc"
alias reload="exec ${SHELL} -l"
alias kx='kubectx'
alias afk="pmset displaysleepnow"

unsetopt inc_append_history
unsetopt share_history

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

### fzf ############################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-m
--color fg:-1,bg:-1,hl:120,fg+:3,bg+:233,hl+:229
--color info:140,prompt:120,spinner:150,pointer:167,marker:174'


# fep - find and edit file
fep() {
    local files=$(fzf --query="$1" --select-1 --exit-0 --preview="bat --color=always {}" --preview-window=right:50%:wrap | sed -e "s/\(.*\)/\'\1\'/")
    local command="${EDITOR:-vim} -p $files"
    [ -n "$files" ] && eval $command
}

# fag - find an argument with rg and fzf and open with vim
# fag() {
#   out=$(rg \
# 	--column \
# 	--line-number \
# 	--no-column \
# 	--no-heading \
# 	--fixed-strings \
# 	--ignore-case \
# 	--hidden \
#     -s \
# 	--follow \
# 	--glob '!.git/*' "$1" \
# 	| awk -F  ":" '/1/ {start = $2<5 ? 0 : $2 - 5; end = $2 + 5; print $1 " " $2}' \
#     | fzf --preview 'bat --wrap character --color always {1} --highlight-line {2}' --preview-window wrap)

#     read -r filename line <<< "${out}"
#     ${EDITOR:-vim} "${filename}" +"normal! ${line}zz"
# }
#

# fag - find an argument with ag and fzf and open with vim
fag() {
    [ $# -eq 0  ] && return
    local out cols
    if out=$(ag --nogroup --color "$@" | fzf --ansi); then
        setopt sh_word_split
        cols=(${out//:/  })
        unsetopt sh_word_split
        vim ${cols[1]} +"normal! ${cols[2]}zz"
    fi
}

# cdf - cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fshow - git commit browser
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(cyan)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | delta'"
fshow() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
            --bind "enter:execute:$_viewGitLogLine | less -Ri" \
            --preview-window=right:50%:wrap
}
#####################################

export VIRTUAL_ENV="$HOME/workspace/venv/default3"
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
    source "${VIRTUAL_ENV}/bin/activate"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Kitty #########################
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
# Kitty tab name
function set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}
function set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
####################################
