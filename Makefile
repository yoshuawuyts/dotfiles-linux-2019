all: install

install:
	@./setup/index.sh

help:
	@echo "Usage:"
	@echo ""
	@echo "  make [command]"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "  all                    :install"
	@echo "  install                Install all the things"
	@echo "  help                   Display help"
