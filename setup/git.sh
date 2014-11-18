setup_git() {
  git config --global user.name "yoshuawuyts";
  git config --global user.email i@yoshuawuyts.com;
}

setup_keychain() {
  git config --global credential.helper osxkeychain;
}

main() {
  setup_git;
  setup_keychain;
}

main;
