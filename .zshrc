# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export MACHINE_ARCH=$(uname -m)

#
# User configuration sourced by interactive shells
#
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

export MYSQL_PS1="\R:\m:\s - \u@\h [\d]> "

export EDITOR='vim'
alias vi="vim"
alias ag="ag --pager \"less -R\""
alias psgr="ps -ef | grep -v grep | grep"
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias tf="tail -f"
alias tfn="tail -f -n0"
alias grep="grep -v grep | grep"
alias rm="rm -iv"
alias mv="mv -iv"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"
alias ttfb="curl -L -s -w '\nLookup time:\t%{time_namelookup}\nConnect time:\t%{time_connect}\nAppCon time:\t%{time_appconnect}\nRedirect time:\t%{time_redirect}\nPreXfer time:\t%{time_pretransfer}\nStartXfer time:\t%{time_starttransfer}\n\nTotal time:\t%{time_total}\n' -o /dev/null"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dinspec='docker run -it --rm -v $(pwd):/share chef/inspec'
alias checkssldate='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates };f'
alias rmkh='f() { sed -i.bak -e '${1}d' /home/hannes/.ssh/known_hosts };f'
alias ip="ip -c"
alias ipb="ip -br"
alias octperm="stat -c \"%a %n\""
alias sshp="ssh -o PreferredAuthentications=password"
alias less="less -R"
alias lsd="lsd --icon=never"
alias ls="ls --color=auto"
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
alias checkssl='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -text -noout };f'
alias checkssldate='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates };f'
alias checksslsubject='f() { echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -subject };f'
alias checksslcert_local_date='f() { openssl x509 -in $1 -text -noout | grep -i after 2>/dev/null};f'
alias checksslcert_local='f() { openssl x509 -in $1 -text -noout 2>/dev/null};f'
alias batcat=bat

## Functions
function petpre() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function rgl() {
  rg -p "$@" | less -XFR
}

function backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir


if [[ ! -d "/${HOME}/.zinit/bin" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi
if [[ ! -d "/${HOME}/.asdf" ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
    autoload -Uz compinit && compinit
    . $HOME/.asdf/asdf.sh
    asdf update
#    asdf plugin-add rust
#    asdf plugin-add golang
#    asdf install rust 1.41.0
#    asdf install golang 1.13.7
#    asdf global rust 1.41.0
#    asdf global golang 1.13.7

fi
if [[ ! -f "/${HOME}/.vim/autoload/plug.vim" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^H" backward-kill-word
bindkey "^W" backward-kill-dir

### Added by Zplugin's installer
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk
# Two regular plugins loaded without tracking.
zinit light zsh-users/zsh-autosuggestions
zplg ice depth'1' blockf
zinit light zsh-users/zsh-completions

# Plugin history-search-multi-word loaded with tracking.
zinit load zdharma/history-search-multi-word

zinit ice depth=1; zinit light romkatv/powerlevel10k
## Load the pure theme, with zsh-async library that's bundled with it.
#zinit ice pick"async.zsh" src"pure.zsh"
#zinit light sindresorhus/pure

#zinit ice wait'!' lucid nocompletions \
#         compile"{zinc_functions/*,segments/*,zinc.zsh}" \
#         atload'!prompt_zinc_setup; prompt_zinc_precmd'
#zinit load robobenklein/zinc
#
## ZINC git info is already async, but if you want it
## even faster with gitstatus in Turbo mode:
## https://github.com/romkatv/gitstatus
#zinit ice wait'1' atload'zinc_optional_depenency_loaded'
#zinit load romkatv/gitstatus

# After finishing the configuration wizard change the atload'' ice to:
# -> atload'source ~/.p10k.zsh; _p9k_precmd'
# if [[ ! -f "/${HOME}/.p10k.zsh" ]]; then
#     zinit ice wait'!' lucid atload'true; _p9k_precmd' nocd
# else
#     zinit ice wait'!' lucid atload'source ~/.p10k.zsh; _p9k_precmd'
# fi
# zinit light romkatv/powerlevel10k

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin
setopt promptsubst

zinit ice wait lucid
zinit snippet OMZ::lib/git.zsh
zinit ice wait atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh
#PS1="READY >" # provide a nice prompt till the theme loads
#zinit ice wait'!' lucid
#zinit snippet OMZ::themes/dstufft.zsh-theme
zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

## programs
if [[ "${MACHINE_ARCH}" == "x86_64" ]];then
  # sharkdp/fd
  zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*x86_64-unknown-linux-gnu*" pick"fd/fd"
  zinit light sharkdp/fd
  # sharkdp/bat
  zinit ice as"command" from"gh-r" mv"bat*/bat -> bat" pick"bat"
  zinit light sharkdp/bat
  # ogham/exa, replacement for ls
  zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
  zinit light ogham/exa
  # BurntSushi/ripgrep
  zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
  zinit light BurntSushi/ripgrep
  # b4b4r07/httpstat
  zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
  zinit light b4b4r07/httpstat
  #dbrgn/tealdeer
  zinit ice as"command" from"gh-r" mv"tldr* -> tldr" pick"dbrgn/tealdeer"
  zinit light dbrgn/tealdeer
  #derailed/k9s
  zinit ice as"command" from"gh-r" mv"k9s* -> k9s" pick"derailed/k9s"
  zinit light derailed/k9s
  #bootandy/dust
  zinit ice as"command" from"gh-r" mv"dust*unknown-linux-gnu/dust -> dust" pick"dust"
  zinit light bootandy/dust
  #cjbassi/ytop
  zinit ice as"command" from"gh-r" mv"ytop* -> ytop" pick"cjbassi/ytop"
  zinit light cjbassi/ytop
  #sharkdp/hyperfine
  zinit ice as"command" from"gh-r" mv"hyperfine*/hyperfine -> hyperfine" pick"sharkdp/hyperfine"
  zinit light sharkdp/hyperfine
  #pemistahl/grex
  zinit ice as"command" from"gh-r" mv"grex* -> grex" pick"pemistahl/grex"
  zinit light pemistahl/grex
  #imsnif/bandwhich
  zinit ice as"command" from"gh-r" mv"bandwhich* -> bandwhich" pick"imsnif/bandwhich"
  zinit light imsnif/bandwhich
  #chmln/sd
  zinit ice as"command" from"gh-r" mv"sd* -> sd" pick"sd"
  zinit light chmln/sd
  #dalance/procs
  zinit ice as"command" from"gh-r" mv"procs* -> procs" bpick"*lnx*"
  zinit light dalance/procs
  #dandavison/delta
  zinit ice as"command" from"gh-r" mv"*x86_64-unknown-linux-gnu/delta -> delta" bpick"*x86_64-unknown-linux-gnu*" pick"delta"
  zinit light dandavison/delta
  # ogham/dog
  zinit ice as"command" from"gh-r" mv"dog* -> dog" bpick"*x86_64-unknown-linux-gnu*" pick"bin/dog"
  zinit light ogham/dog
elif [[ "${MACHINE_ARCH}" == "aarch64" ]];then
#  # sharkdp/fd
#  zinit ice as"command" from"gh-r" mv"fd* -> fd" bpick"*arm-unknown-linux-gnu*" pick"fd/fd"
#  zinit light sharkdp/fd
#  # sharkdp/bat
#  zinit ice as"command" from"gh-r" mv"bat*/bat -> bat" bpick"*arm-unknown-linux-gnu*" pick"bat"
#  zinit light sharkdp/bat
  # BurntSushi/ripgrep
  zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" bpick"*arm-unknown-linux-gnu*" pick"ripgrep/rg"
  zinit light BurntSushi/ripgrep
  # b4b4r07/httpstat
  zinit ice as"program" cp"httpstat.sh -> httpstat" pick"httpstat"
  zinit light b4b4r07/httpstat
  #dbrgn/tealdeer
  zinit ice as"command" from"gh-r" mv"tldr* -> tldr" bpick"tldr-linux-armv7-musleabihf" pick"dbrgn/tealdeer"
  zinit light dbrgn/tealdeer
  #derailed/k9s
  zinit ice as"command" from"gh-r" mv"k9s* -> k9s" bpick"k9s_Linux_arm64.tar.gz" pick"derailed/k9s"
  zinit light derailed/k9s
  #bootandy/dust
  zinit ice as"command" from"gh-r" mv"dust*unknown-linux-gnu/dust -> dust" bpick"arm-unknown-linux-gnueabihf*" pick"dust"
  zinit light bootandy/dust
fi




# loaded at the end, like it is suggested by the plugin's README
zinit light zdharma/fast-syntax-highlighting

autoload -Uz compinit && compinit
. $HOME/.asdf/asdf.sh

zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
