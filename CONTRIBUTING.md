# Contributing

This tap packages release artifacts; it does not build or publish upstream
projects. Keep source releases and tap updates as separate reviewable gates.

## Update existing formulae

The scheduled workflow runs the same command maintainers can run locally:

```bash
brew ruby -- scripts/update-formulae.rb
git diff -- Formula
./scripts/check.sh
```

The updater selects the newest eligible non-draft GitHub Release, requires all
four supported OS/CPU assets, reads their GitHub-computed SHA-256 digests, and
only then rewrites Formula files. If any platform asset is absent, no Formula
is written.

Use `--check` in verification jobs and `--formula NAME` for focused work:

```bash
brew ruby -- scripts/update-formulae.rb --check
brew ruby -- scripts/update-formulae.rb --formula pig
```

## Add a formula

1. Publish tagged binaries for Darwin/Linux on arm64/amd64 in the upstream
   repository. Do not point a Formula at a mutable branch artifact.
2. Add a Formula with one `# update: <platform>` marker immediately before each
   URL/SHA pair.
3. Add its release and asset-name contract to `PgstyInfra::Catalog` in
   `scripts/update-formulae.rb`.
4. Extend `test/update_formulae_test.rb` and both README formula tables.
5. Run `./scripts/check.sh`, then install and test the Formula on at least one
   real supported host.

Use the `Homebrew CI` workflow's `smoke` dispatch to install and test the
complete Formula set on both GitHub-hosted macOS and Linux runners.

## Delivery gates

Report these independently: local audit/test, commit, push, GitHub Actions,
upstream tag/release, and end-user `brew install` verification. A successful
source build is not proof that a release asset or Tap Formula exists.
