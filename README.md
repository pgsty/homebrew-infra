# PGSTY Homebrew Tap

[中文说明](README.zh.md) · [PGSTY](https://pgsty.com)

Homebrew formulae for PGSTY infrastructure software. Every formula installs a
checksum-pinned, upstream GitHub Release binary; no compiler toolchain is needed.

## Install

```bash
brew tap pgsty/tap

brew install pgsty/tap/silo
brew install pgsty/tap/mcli
brew install pgsty/tap/silo-console
brew install pgsty/tap/pig
brew install pgsty/tap/sow
brew install pgsty/tap/farrow
brew install pgsty/tap/pg-exporter
```

The fully qualified `pgsty/tap/pig` name is intentional. Homebrew Core already
contains Apache Pig, while this tap's `pig` is the PGSTY PostgreSQL CLI.

## Formulae

| Formula | Installed command | Purpose | Release source |
|:--|:--|:--|:--|
| `silo` | `silo` | S3-compatible object storage server | [`pgsty/silo`](https://github.com/pgsty/silo/releases) |
| `mcli` | `mcli` | Silo/S3 command-line client | [`pgsty/mc`](https://github.com/pgsty/mc/releases) |
| `silo-console` | `silo-console` | Administrative web console | [`pgsty/silo-console`](https://github.com/pgsty/silo-console/releases) |
| `pig` | `pig` | PostgreSQL extension package manager and CLI | [`pgsty/pig`](https://github.com/pgsty/pig/releases) |
| `sow` | `sow` | Local RPM/DEB repository manager | [`pgsty/sow`](https://github.com/pgsty/sow/releases) |
| `farrow` | `farrow` | Native QEMU runtime for Pigsty development VMs | [`pgsty/farrow`](https://github.com/pgsty/farrow/releases) |
| `pg-exporter` | `pg_exporter` | PostgreSQL/PgBouncer Prometheus exporter | [`pgsty/pg_exporter`](https://github.com/pgsty/pg_exporter/releases) |

The tap supports Apple Silicon and Intel macOS, plus arm64 and x86_64 Linux.

## Common operations

```bash
brew update
brew upgrade pgsty/tap/silo pgsty/tap/mcli pgsty/tap/pig
brew uninstall pgsty/tap/pig
brew untap pgsty/tap
```

Silo includes an optional Homebrew service:

```bash
brew services start pgsty/tap/silo
brew services stop pgsty/tap/silo
```

Set production credentials before starting Silo. Run `brew info pgsty/tap/silo`
for its data path and service notes.

## Release integrity and updates

- Formulae pin one GitHub Release asset and SHA-256 for each supported OS/CPU pair.
- Draft releases are ignored. Prereleases are ignored except for Farrow, whose
  current `v0.1.0` release is explicitly marked as a prerelease upstream.
- A scheduled updater changes all four platform URLs and hashes atomically and
  opens a reviewable pull request.
- Homebrew's test-bot checks formula syntax and install/test behavior on macOS
  and Linux for pull requests.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the maintenance workflow and
[SECURITY.md](SECURITY.md) for reporting integrity or security issues.

## Local validation

```bash
brew tap pgsty/tap /absolute/path/to/homebrew-tap
./scripts/check.sh
```

This checks Ruby syntax, updater invariants, current release metadata, Homebrew
style, and strict online formula audits. Omit the path when validating the
published GitHub repository.
