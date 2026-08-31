#!/usr/bin/env bash
set -euo pipefail

tap_root=$(cd "$(dirname "$0")/.." && pwd -P)
cd "${tap_root}"
ruby_bin="$(brew --repository)/Library/Homebrew/vendor/portable-ruby/current/bin/ruby"

for formula in Formula/*.rb
do
  "${ruby_bin}" -c "${formula}" >/dev/null
done

brew ruby -- test/update_formulae_test.rb
brew ruby -- scripts/update-formulae.rb --check

tap_name=${HOMEBREW_TAP_NAME:-pgsty/infra}
if ! brew tap | grep -Fqx "${tap_name}"
then
  printf 'tap %s is not installed; run: brew tap %s <repository-url-or-path>\n' "${tap_name}" "${tap_name}" >&2
  exit 2
fi

brew style "${tap_name}"

for formula in Formula/*.rb
do
  formula_name=$(basename "${formula}" .rb)
  brew audit --strict --online --formula "${tap_name}/${formula_name}"
done
