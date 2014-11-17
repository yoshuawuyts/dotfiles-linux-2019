main() {
  ln -s $(pwd)/lib/.atom ~/.atom
  ln -s $(pwd)/lib/.aliases ~/.aliases
  ln -s $(pwd)/lib/.bash_profile ~/.bash_profile
  ln -s $(pwd)/lib/.bashrc ~/.bashrc
  ln -s $(pwd)/lib/.exports ~/.exports
  ln -s $(pwd)/lib/.gitconfig ~/.gitconfig
  ln -s $(pwd)/lib/.vimrc ~/.vimrc
  ln -s $(pwd)/lib/.zshrc ~/.zshrc
}

main
