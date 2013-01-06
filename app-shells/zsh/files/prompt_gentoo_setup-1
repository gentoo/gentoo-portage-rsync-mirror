# gentoo prompt theme

prompt_gentoo_help () {
  cat <<'EOF'
This prompt is color-scheme-able.  You can invoke it thus:

  prompt gentoo [<promptcolor> [<usercolor> [<rootcolor>]]]

EOF
}

prompt_gentoo_setup () {
  prompt_gentoo_prompt=${1:-'blue'}
  prompt_gentoo_user=${2:-'green'}
  prompt_gentoo_root=${3:-'red'}

  if [ "$USER" = 'root' ]
  then
    base_prompt="%B%F{$prompt_gentoo_root}%m%k "
  else
    base_prompt="%B%F{$prompt_gentoo_user}%n@%m%k "
  fi
  post_prompt="%b%f%k"

  #setopt noxtrace localoptions

  path_prompt="%B%F{$prompt_gentoo_prompt}%1~"
  PS1="$base_prompt$path_prompt %# $post_prompt"
  PS2="$base_prompt$path_prompt %_> $post_prompt"
  PS3="$base_prompt$path_prompt ?# $post_prompt"
}

prompt_gentoo_setup "$@"
