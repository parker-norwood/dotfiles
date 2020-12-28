# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Antigen
source ~/.antigen/antigen.zsh

# Load oh-my-zsh library.
antigen use oh-my-zsh

# Load bundles from the default repo (oh-my-zsh).
antigen bundle git
antigen bundle nvm
antigen bundle npm
antigen bundle pip
antigen bundle ubuntu
antigen bundle docker
antigen bundle command-not-found

# Load bundles from external repos.
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle webyneter/docker-aliases

# Select theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# alias kittens
if [ $TERM = "xterm-kitty" ]; then
  alias icat="kitty +kitten icat"
  alias ssh="kitty +kitten ssh"
fi

# MicroK8s uses a namespaced kubectl command to prevent conflicts with any existing installs of kubectl.
# If you don't have an existing install, it is easier to add an alias (append to ~/.bash_aliases) like this:
alias kubectl='microk8s.kubectl'

# some more ls aliases
alias ll="ls -alF"

# enable fzf keybindings
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
