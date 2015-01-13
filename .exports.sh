#
# User configuration
#

configure_path() {
  export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
}

configure_docker() {
  export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375;
}


configure_terraform() {
  export PATH=$PATH:~/Library/Terraform;
}

configure_node() {
  export NVM_DIR=~/.nvm;
}

configure_go() {
  if [ "" = "${GOPATH}" ]; then
    # export GOPATH="/some/dir"
  fi
}

main() {
  configure_path;
  configure_docker;
  configure_terraform;
  configure_node;
  configure_go;
}

main;
