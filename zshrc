# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
plugins=(git macos common-aliases kubectl terraform colored-man-pages)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GOPATH=$HOME/workspace/go
export EDITOR=${EDITOR:-nvim}
export LESS=-Ri
export KUBE_EDITOR="nvim"
export PATH=$PATH:$HOME/workspace/venv/default/bin/:/usr/local/bin:$GOPATH/bin:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/sbin:$HOME/Library/Python/3.8/bin:~/bin:${KREW_ROOT:-$HOME/.krew}/bin
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
export TERM=xterm-256color
export HISTSIZE=10000000
export SAVEHIST=10000000
setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

alias ls='gls --color=auto'
alias vim="nvim"
alias vimdiff="nvim -d"
alias vi=nvim
alias rm='rm -i'
alias cp='cp -i'
alias mv="mv -i"
alias less="bat --theme=TwoDark"
alias cat="bat --theme=TwoDark"
alias reload="exec ${SHELL} -l"
alias kx='kubectx'
alias kn='kubens'
alias afk="pmset displaysleepnow"
alias l='ls -lrth'
alias review='git push origin HEAD:refs/for/main'
alias kshell='kubectl run -it --image bash --restart Never --rm shell'
alias vd='ssh -L 8888:localhost:8888 vd'
alias jlogin='tsh status || tsh_login'
alias vir='nvim --server localhost:8888 --remote-ui'
alias resetmouse='printf '"'"'\e[?1000l'"'"

unsetopt inc_append_history
unsetopt share_history

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

### fzf ############################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='-m
--color fg:-1,bg:-1,hl:120,fg+:3,bg+:233,hl+:229
--color info:140,prompt:120,spinner:150,pointer:167,marker:174'


# fep - find and edit file
fep() {
    local files=$(fzf --query="$1" --select-1 --exit-0 --preview="bat \
    --color=always {}" --preview-window=right:50%:wrap | sed -e \
    "s/\(.*\)/\'\1\'/")
    local command="${EDITOR:-vim} -p $files"
    [ -n "$files" ] && eval $command
}

# fag - find an argument with ag and fzf and open with vim
farg() {
    [ $# -eq 0  ] && return
    local out cols
    if out=$(rg --color always --line-number --no-heading "$@" | fzf --ansi); then
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

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [[ -e "$HOME/workspace/venv/default3/bin/activate" ]]; then
    source "$HOME/workspace/venv/default3/bin/activate"
fi
