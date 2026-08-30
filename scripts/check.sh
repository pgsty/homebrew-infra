#!/usr/bin/env bash
set -euo pipefail

tap_root=$(cd "$(dirname "$0")/.." && pwd -P)
cd "${tap_root}"

for formula in Formula/*.rb; do
  ruby -c "${formula}" >/dev/null
done

ruby test/update_formulae_test.rb
ruby scripts/update-formulae.rb --check
brew style Formula/*.rb

tap_name=${HOMEBREW_TAP_NAME:-pgsty/tap}
if ! brew tap | grep -Fqx "${tap_name}"; then
  printf 'tap %s is not installed; run: brew tap %s <repository-url-or-path>\n' "${tap_name}" "${tap_name}" >&2
  exit 2
fi

for formula in Formula/*.rb; do
  formula_name=$(basename "${formula}" .rb)
  brew audit --strict --online --formula "${tap_name}/${formula_name}"
done
