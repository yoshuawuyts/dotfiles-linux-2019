setup_git() {
  git config --global user.name "yoshuawuyts";
  git config --global user.email i@yoshuawuyts.com;
}

setup_keychain() {
  git config --global credential.helper osxkeychain;
}

setup_config() {
  git config --global push.default simple;
}

main() {
  setup_git;
  setup_keychain;
  setup_config;
}

main;
