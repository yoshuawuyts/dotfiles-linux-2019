#!/bin/bash

VERSION="0.0.1"

## sets optional variable from environment
opt () { eval "if [ -z "\${$1}" ]; then ${1}=${2}; fi"; }

opt TMPDIR "/tmp/"
opt CACHE_DIR="${TMPDIR}nman-cache"
opt OUTPUT="ronn"
opt API_URL "https://raw.githubusercontent.com/joyent/node/master/doc/api"
opt DOC_EXT "markdown"

## output usage
usage () {
  {
    echo "usage: nman [-hV]"
    echo ""
    echo "examples:"
    echo "  $ nman fs"
    echo "  $ nman stream"
    echo "  $ nman buffer"
  } >&2
}

## output error
error () {
  {
    printf "error: %s\n" "${@}"
  } >&2
}

## main
nman () {
  local mod="$1"
  local let is_cached=0
  local url="${API_URL}/${mod}.${DOC_EXT}"
  local mdfile="${CACHE_DIR}/${mod}.${DOC_EXT}"
  local manfile="${CACHE_DIR}/${mod}.man"
  local md=""
  local man=""

  ## ensure cache dir exists
  if ! test -d "${CACHE_DIR}"; then
    mkdir -p "${CACHE_DIR}"
  fi

  ## if it exists in cache dir then
  ## use it with output method
  if test -f "${mdfile}" && test -f "${manfile}"; then
    md="$(cat ${mdfile})"
    is_cached=1
  else
    ## fetch new copy
    md="$(curl -s -L "${url}")"
  fi

  ## fail on bad rc
  if [ "$?" -gt "0" ]; then
    return 1
  fi

  ## fail on empty buf
  if [ -z "${md}" ]; then
    return 1
  fi

  if [ "0" == "${is_cached}" ]; then
    ## store cache
    touch "${mdfile}"
    {
      echo "node - ${mod}"
      echo "===================="
      echo ""
      echo "${md}"
    } >> "${mdfile}"
  fi

  if [ "stdout" = "${OUTPUT_METHOD}" ]; then
    cat "${mdfile}"
    return 0
  fi

  if test -f "${manfile}"; then
    man "${manfile}"
    return $?
  fi

  ## determine output method
  case "${OUTPUT_METHOD}" in
    ronn)
      man="$(ronn -W -r --pipe ${mdfile} 2>/dev/null)"
      ;;

    curl)
      man="$(curl -s -# -F page=@${mdfile} http://mantastic.herokuapp.com)"
      ;;

    *) return 1 ;;
  esac

  rm -f "${manfile}"
  touch "${manfile}"
  echo "${man}" >> "${manfile}"
  man "${manfile}"
}

## feature test
features () {

 case "${OUTPUT}"  in
   stdout)
     OUTPUT_METHOD="stdout"
     ;;

   curl)
     OUTPUT_METHOD="curl"
     ;;

   *)
     OUTPUT_METHOD="ronn"
     ;;
 esac

 if [ "stdout" != "${OUTPUT}" ]; then
   if ! type -f "${OUTPUT_METHOD}" > /dev/null 2>&1; then
     OUTPUT_METHOD="curl"
     if ! type -f curl > /dev/null 2>&1; then
       error "Unable to determine a suitable output method"
       exit -1
     fi
   fi
 fi
}

## parse opts
{
  while true; do
    arg="$1"
    if [ "" = "${arg}" ]; then
      usage
      exit 1
    elif [ "-" != "${arg:0:1}" ]; then
      break;
    fi

    case "${arg}" in
      -V|--version)
        echo "${VERSION}"
        exit 0
        ;;

      -h|--help)
        usage
        exit 0
        ;;

      *)
        error "Unknown option: \`${arg}'"
        usage
        exit 1
        ;;
    esac
    shift
  done
}

## detect feature output
features

nman "$@"
exit $?
