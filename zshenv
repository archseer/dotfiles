# Correct XDG paths

# Unfortunately some tools will not use XDG directories unless these are set
#
# - Hex
# - Mix
# - NV
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_DIRS" ] && export XDG_CONFIG_DIRS="/etc/xdg"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_DIRS"   ] && export XDG_DATA_DIRS="/usr/local/share:/usr/share"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="$HOME/.config/zsh"
export INPUTRC="$HOME/.config/inputrc"
# Cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
# Rustup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Setup path

# put ~/bin on PATH if you have it
test -d "$HOME/bin" &&
  PATH="$HOME/bin:$PATH"

# add jenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# add go
export GOPATH="$HOME/src/go"
export PATH="${GOPATH//://bin:}/bin:$PATH"
# add yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# add rust
export PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
# add llvm
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Compile packages with -j8
export MAKEFLAGS="-j8"
export CFLAGS="-march=native -mtune=native"
export CXXFLAGS="${CFLAGS}"
# export RUSTFLAGS="-C target-cpu=native"

