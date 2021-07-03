if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
plugins=(git docker osx common-aliases virtualenv kubectl)
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
export SSH_KEY_PATH="~/.ssh/rsa_id"
export GOPATH=$HOME/workspace/go
export PATH=/usr/local/opt/openssl/bin:$PATH:$GOPATH/bin:~/workspace/repo/utilities/list_instances/aws/:~/tmp/roer
export EDITOR=nvim
export LESS=-Ri
export MANPAGER="nvim -c 'set ft=man' -"
export KUBE_EDITOR="nvim"
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export PATH=$PATH:$HOME/workspace/venv/default/bin/:/usr/local/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'


alias ls='gls --color=auto'
alias gitlog='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --all'
alias dockerdeli='docker rm $(docker ps -q -f status=exited)'
alias vim="nvim"
alias vimdiff="nvim -d"
alias vi=nvim
alias rm='rm -i'
alias cp='cp -i'
alias mv="mv -i"
alias repo='cd ~/workspace/repo'
alias dep='cd ~/workspace/repo/deployment'
alias spin='cd ~/workspace/repo/spinnaker/'
alias gsso='gcert'
alias less="bat --theme=TwoDark"
alias cat="bat --theme=TwoDark"
alias vimrc="$EDITOR ~/.vimrc"
alias reload="exec ${SHELL} -l"
alias kx='kubectx'
alias afk="pmset displaysleepnow"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
unsetopt inc_append_history
unsetopt share_history

source ~/.zshrc_google

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt
antibody bundle romkatv/powerlevel10k

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
fag() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# cdf - cd into the directory of the selected file
cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# z - jump to directory with with z and fzf
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
#####################################

export VIRTUAL_ENV="$HOME/workspace/venv/default3"
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
    export VIRTUALENVWRAPPER_PYTHON="$VIRTUAL_ENV/bin/python3"
    export WORKON_HOME="$HOME/workspace/venv"
    source $HOME/workspace/venv/default3/bin/virtualenvwrapper.sh
    source "${VIRTUAL_ENV}/bin/activate"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


#### FIG ENV VARIABLES ####
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

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
