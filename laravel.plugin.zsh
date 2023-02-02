# Copyright (c) Bruno Sales <me@baliestri.dev>. Licensed under the MIT License.
# See the LICENSE file in the project root for full license information.

function __find_laravel_root() {
  local current_path="$(pwd)"
  local laravel_path=""

  until [[ "${current_path}" -ef "/" ]]; do
    if [[ -f "${current_path}/artisan" ]]; then
      laravel_path="${current_path}"
      break
    fi

    current_path="$(dirname "${current_path}")"
  done

  echo "${laravel_path}"
}

function __find_docker_compose() {
  if (( ! $+commands[docker] )); then
    return 1
  fi

  local plugin=$(docker compose 2>&1 | grep -o "docker compose")

  if [[ -n "${plugin}" ]]; then
    echo "docker compose"
  elif (( $+commands[docker-compose] )); then
    echo "docker-compose"
  else
    return 1
  fi
}

function __artisan_completion() {
  compadd $(php $(__find_laravel_root)/artisan list --raw --no-ansi | awk '{print $1}' | sed 's/:$//')
}

function __check_artisan() {
  if [[ -z "$(__find_laravel_root)" ]]; then
    unfunction artisan &>/dev/null
    return 1
  fi

  function artisan() {
    eval "php $(__find_laravel_root)/artisan $@"
  }

  compdef __artisan_completion artisan
}

function __check_sail() {
  if [[ -z "$(__find_laravel_root)" ]] || [[ -z "$(__find_docker_compose)" ]]; then
    unfunction sail &>/dev/null
    return 1
  fi

  if [[ ! -f "$(__find_laravel_root)/vendor/bin/sail" ]]; then
    unfunction sail &>/dev/null
    return 1
  fi

  function sail() {
    eval "$(__find_laravel_root)/vendor/bin/sail $@"
  }
}

add-zsh-hook chpwd __check_artisan
add-zsh-hook chpwd __check_sail
