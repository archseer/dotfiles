# Setup path

# Add the missing sbin to path
export PATH="/usr/local/sbin:$PATH"

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
  PATH="$HOME/bin:$PATH"

# add rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# add jenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# add go
export GOPATH="$HOME/src/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"
# add yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# add rust
export PATH="$HOME/.cargo/bin:$PATH"
# add llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Correct XDG paths
export ZDOTDIR="$HOME/.config/zsh"
