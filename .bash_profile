# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$GOPATH/bin:$PATH
export GOPATH=$HOME
# export PATH=/Users/tetianadushenkivska/projects/elixir/bin:$PATH
