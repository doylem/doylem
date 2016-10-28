# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=9999
SAVEHIST=2000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/doylem/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /opt/boxen/env.sh

function powerline_precmd() {
    export PS1="$(~/powerline-shell/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

install_powerline_precmd

# Shell
alias ll='ls -lah'
alias vi='vim'

# Ruby
alias be='bundle exec'
alias bi='bundle install --local'
alias fs='bundle exec foreman start'
alias dbm='bundle exec rake db:migrate; git checkout db/schema.rb'
alias capdep='bundle exec cap deploy'
alias dep='script/deploy_green'
alias zc='zeus cucumber'
alias zr='zeus rspec'

# Boxen / puppet
alias boxen='boxen --stealth --debug --profile'

# tmux
alias tmux="TERM=screen-256color-bce tmux"
alias mmp="cd ~/mp; mux mp"
alias mlb="cd ~/lb; mux lb"
alias tml="tmux list-sessions"
alias tmk="tmux kill-session -t mp; tmux kill-session -t lb"
alias tmkmp="tmux kill-session -t mp"
alias tmklb="tmux kill-session -t lb"

# git stuff
alias gco='git checkout'
alias gcb='git checkout -b'
alias gs='git st'
alias s='git st'
alias gpr='git pull-request'
alias gd='git diff'
alias gdc='git diff --cached'
alias d='git diff .'
alias gap='git add --patch'
alias ga='git add'
alias a='git add .'
alias gca='git commit -a'
alias gc='git commit'
alias c='git commit'
alias cm='git commit -m'
alias gsp='git smart-pull'
alias gt='git tree'
alias gb='git branch'
alias b='git branch'
alias gbk='git buildkite'
alias gmm='git smart-merge master'
alias gsm='git smart-merge'
alias gcm='git checkout master'
alias M='git checkout master'
alias gt='git stash'
alias t='git stash'
alias gtp='git stash pop'
alias tp='git stash pop'
alias gr='git reset'
alias r='git reset'
alias gfw='git fixws'
alias gcp='git cherry-pick'
alias gl='git smart-log'
alias l='git smart-log'

# these alias ignore changes to file
alias gignore='git update-index --assume-unchanged'
alias gunignore='git update-index --no-assume-unchanged'
# list temporarily ignored files
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

# Cleans all old branches
alias gbclean='git branch --merged | xargs git branch -d'

# Push to current branch
function branch() {
ref=$(git symbolic-ref HEAD)
  echo "${ref#refs/heads/}"
}
alias gp='git push origin $(branch)'
alias p='git push origin $(branch)'
alias pstage='git push -f origin $(branch):staging'

alias csvdump='cd ~/src/loading_bay_backend/; cap db:pg_dump_and_restore_local && rake metadata:extract | gzip > ~/Desktop/loading-bay_db_export_`date +%Y%m%dT%H%M%S`.csv.gz'

source ~/.bin/tmuxinator.zsh


# Elements
alias mel="cd ~/src/elements_frontend; mux el"

export PATH=~/bin:$PATH

export NVM_DIR="/Users/doylem/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

function _keychain() {
  keychain="envato.keychain"
  service="elements-development"
  key=${1}
  security find-generic-password -a $service -s $key -w $keychain
}

function _keychain_hex() {
  _keychain $1 | perl -pe 's/([0-9a-f]{2})/chr hex $1/gie'
}

function elements-environment() {
  AWS_ACCESS_KEY_ID=$(_keychain aws_access_key_id) \
  AWS_SECRET_ACCESS_KEY=$(_keychain aws_secret_access_key) \
  BRAINTREE_ENVIRONMENT=$(_keychain braintree_environment) \
  BRAINTREE_MERCHANT_ID=$(_keychain braintree_merchant_id) \
  BRAINTREE_PUBLIC_KEY=$(_keychain braintree_public_key) \
  BRAINTREE_PRIVATE_KEY=$(_keychain braintree_private_key) \
  CLOUDFRONT_KEY_PAIR_ID=$(_keychain cloudfront_key_pair_id) \
  CLOUDFRONT_KEY_PAIR=$(_keychain_hex cloudfront_key_pair) \
  CLOUDFRONT_DOMAIN=$(_keychain cloudfront_domain) \
  CLOUDINARY_CLOUD_NAME=$(_keychain cloudinary_cloud_name) \
  CLOUDINARY_API_KEY=$(_keychain cloudinary_api_key) \
  CLOUDINARY_API_SECRET=$(_keychain cloudinary_api_secret) \
  $*
}
alias ee="elements-environment"

