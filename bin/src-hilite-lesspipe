#! /bin/sh

for source in "$@"; do
    case $source in
	*ChangeLog|*changelog)
        source-highlight --failsafe -f esc --lang-def=changelog.lang --style-css-file=$HOME/.source-highlight/my.css -i "$source" ;;
	*Makefile|*makefile)
        source-highlight --failsafe -f esc --lang-def=makefile.lang --style-css-file=$HOME/.source-highlight/my.css -i "$source" ;;
        *) source-highlight --failsafe --infer-lang -f esc --style-css-file=$HOME/.source-highlight/my.css -i "$source" ;;
    esac
done
