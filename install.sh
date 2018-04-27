#!/bin/bash

echo "Dotfiles install ..."
usage="$(basename "$0") [-h] [-s n] -- Install or update dotfiles

where:
    -h  this help
    -u  update mode. Will add only new dotfile"

updateMode=false
while getopts ':hu:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    u) updateMode=true
       ;;
  esac
done
shift $((OPTIND - 1))

# Get current working directory
CWD=$(pwd)

# Mains files arrays
# create arrays
declare -a confFiles=(
  git/gitconfig
  git/gitignore
  todo-cli/todo.cfg
  vim/vimrc
  zsh/zshrc
  oh-my-zsh/tim.zsh-theme
  jshint/jshintrc
  psql/psqlrc
)

declare -a dests=(
  ~/.gitconfig
  ~/.gitignore
  ~/.todo.cfg
  ~/.vimrc
  ~/.zshrc
  ~/.oh-my-zsh/themes/tim.zsh-theme
  ~/.jshintrc
  ~/.psqlrc
)

# Update mode. Will test symlinks and install missing one
if [ "$updateMode" = true ] ; then
    echo "running update mode ..."

    for i in ${!confFiles[@]}; do
        confFile=${confFiles[$i]}
        dest=${dests[$i]}

        # check for existing symlink
        if [! -L ${dest} ] ; then
            rm ${dest}

            # create symlink
            ln -s ${CWD}/${confFile} ${dest}

            echo "${dest} installed!"
        fi

    done

    exit
fi # End updateMode

# add vim swap, backup and undo directories
mkdir ~/.vim
mkdir ~/.vim/tmp
mkdir ~/.vim/tmp/backup
mkdir ~/.vim/tmp/swap
mkdir ~/.vim/tmp/undo

# install oh-my-zsh
if [ ! -r ~/.oh-my-zsh ]; then
  curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# install Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Get current working directory
CWD=$(pwd)

# create all the files
for i in ${!confFiles[@]}; do
  confFile=${confFiles[$i]}
  dest=${dests[$i]}

  # check for existing files and back them up
  if [ -f ${dest} ] && [ ! -f ${dest}.orig ]; then
    mv ${dest} ${dest}.orig
  elif [ -h ${dest} ]; then
    rm ${dest}
  fi

  # create symlink
  ln -s ${CWD}/${confFile} ${dest}

  echo "${dest} installed!"
done

# create custom env file
touch ~/.env_custom

# Test zsh install and switch to it for the current  user
#
chsh -s $(which zsh)
echo -e "\xF0\x9F\x8D\xBA Installation: Done!"
echo "Sublime settings not installed -- use Package Syncing"
echo "BetterTouchTool preferences not imported"
echo "Iterm preferences not imported"
echo "QuitFrontApp Script not installed"
