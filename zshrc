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
export PATH=$HOME/workspace/venv/default/bin:/usr/local/bin:$GOPATH/bin:${KREW_ROOT:-$HOME/.krew}/bin:/opt/homebrew/sbin:$HOME/bin:$HOME/.local/bin:$PATH
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=180'
export HISTSIZE=10000000
export SAVEHIST=10000000
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
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


source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
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

# fag - find an argument with rg and fzf and open with vim
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

cd() {
  if [[ -f "$1" ]]; then
    builtin cd "${1:h}"
  else
    builtin cd "$@"
  fi
}
#####################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(fnm env --use-on-cd)"
autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
    compinit
done

compinit -C
eval "$(zoxide init zsh)"

zstyle ':completion:*' menu yes select

if [[ -e "$HOME/workspace/venv/default/bin/activate" ]]; then
  source "${HOME}/workspace/venv/default/bin/activate"
fi

####### Auros
export VAULT_ADDR=https://vault.auros.be
alias -g plso="pls -x 30 -a operational -r 90_superuser-assumed -p operational --"
alias -g plsl="pls -x 30 -a legacy -r 90_superuser-assumed -p ktx --"
alias -g pops="pls -x 30 -a operational -r 99_sensitive_superuser-assumed -p operational --"
alias -g ples="pls -x 30 -a legacy -r 99_sensitive_superuser-assumed -p ktx --"
alias vl="vault login -method=oidc"
alias enroll="ssh eran@enroll.auros.be"
export tag=gtar
export AWS_PROFILE=ktx
export LATITUDESH_AUTH_TOKEN=$(security find-generic-password -w -a $USER -s LATITUDESH_AUTH_TOKEN)
export GITLAB_TOKEN=$(security find-generic-password -w -a $USER -s GITLAB_TOKEN)
export CONFLUENCE_USER=eran.davidovich
export CONFLUENCE_TOKEN=$(security find-generic-password -w -a $USER -s CONFLUENCE_TOKEN)
function ussh {
  ssh "$1" -t 'sudo su - ubuntu'
}
tfu() {
  terraform force-unlock -force "$@"
}

export TG_PROVIDER_CACHE=1
export TG_PROVIDER_CACHE_DIR="$HOME/.terragrunt/provider-cache"

# Added by Antigravity
export PATH="/Users/erandavidovich/.antigravity/antigravity/bin:$PATH"

sshls() {
  local d=${ANSIBLE_PATH:-~/workspace/repo/ansible}
  local p=$1
  [[ $# -gt 0 ]] && shift
  local selected=$(grep -ohE '(prod|dev|stage)-\w+-\w+' $d/hosts/*.yaml | sort -u | grep -i "$p" | fzf)
  [[ -n "$selected" ]] && ssh $@ $selected
}

vgit() {
  nvim -p $(git diff --name-only --relative HEAD)
}

###########
