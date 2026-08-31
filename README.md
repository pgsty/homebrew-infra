# PGSTY Infra

[中文说明](README.zh.md) · [PGSTY](https://pgsty.com)

Prebuilt Homebrew formulae for PGSTY and infrastructure software. Every Formula
pins native upstream binaries and SHA-256 checksums for Apple Silicon and Intel
macOS, plus arm64 and x86_64 Linux. No compiler toolchain is required.

## Install

The source repository is intentionally named `pgsty/infra`, not
`pgsty/homebrew-infra`, so the first tap command must include its URL:

```bash
brew tap pgsty/infra https://github.com/pgsty/infra

brew install pgsty/infra/pig
brew install pgsty/infra/silo
brew install pgsty/infra/alertmanager
brew install pgsty/infra/pgschema
```

Use fully qualified names for formulas that collide with Homebrew Core. In
particular, `pgsty/infra/pig` is the PGSTY PostgreSQL CLI, while Core's `pig` is
Apache Pig.

Existing `pgsty/tap` installations keep working through GitHub's repository
redirect. New installations and documentation use `pgsty/infra` as the
canonical tap name.

## PGSTY software

| Formula | Installed command | Purpose | Release source |
|:--|:--|:--|:--|
| `farrow` | `farrow` | Native QEMU runtime for Pigsty development VMs | [`pgsty/farrow`](https://github.com/pgsty/farrow/releases) |
| `mcli` | `mcli` | Silo/S3 command-line client | [`pgsty/mc`](https://github.com/pgsty/mc/releases) |
| `pg-exporter` | `pg_exporter` | PostgreSQL/PgBouncer Prometheus exporter | [`pgsty/pg_exporter`](https://github.com/pgsty/pg_exporter/releases) |
| `pig` | `pig` | PostgreSQL extension package manager and CLI | [`pgsty/pig`](https://github.com/pgsty/pig/releases) |
| `silo` | `silo` | S3-compatible object storage server | [`pgsty/silo`](https://github.com/pgsty/silo/releases) |
| `silo-console` | `silo-console` | Administrative web console | [`pgsty/silo-console`](https://github.com/pgsty/silo-console/releases) |
| `sow` | `sow` | Local RPM/DEB repository manager | [`pgsty/sow`](https://github.com/pgsty/sow/releases) |

## Additional infrastructure software

These projects come from the [`pgsty/infra-pkg`](https://github.com/pgsty/infra-pkg)
catalog, publish native binaries for all four supported OS/CPU pairs, and are
not already covered by Homebrew Core for the same project.

| Formula | Installed command(s) | Purpose |
|:--|:--|:--|
| `agentsview` | `agentsview` | Inspect AI coding-agent sessions and costs |
| `alertmanager` | `alertmanager`, `amtool` | Prometheus alert routing and management |
| `blackbox-exporter` | `blackbox_exporter` | HTTP, DNS, TCP, ICMP, and gRPC probing |
| `headscale` | `headscale` | Self-hosted Tailscale control server |
| `kafka-exporter` | `kafka_exporter` | Kafka Prometheus metrics exporter |
| `loki-canary` | `loki-canary` | End-to-end Loki availability validator |
| `mongodb-exporter` | `mongodb_exporter` | MongoDB Prometheus metrics exporter |
| `mtail` | `mtail` | Extract metrics from application logs |
| `mysqld-exporter` | `mysqld_exporter` | MySQL Prometheus metrics exporter |
| `nginx-exporter` | `nginx_exporter` | NGINX Prometheus metrics exporter |
| `pgbackrest-exporter` | `pgbackrest_exporter` | pgBackRest Prometheus metrics exporter |
| `pgschema` | `pgschema` | Declarative PostgreSQL schema migration |
| `pg-timetable` | `pg_timetable` | PostgreSQL job scheduler |
| `pushgateway` | `pushgateway` | Prometheus gateway for short-lived jobs |
| `redis-exporter` | `redis_exporter` | Redis Prometheus metrics exporter |
| `sabiql` | `sabiql` | Terminal PostgreSQL client |
| `sql-studio` | `sql-studio` | Multi-database terminal SQL explorer |
| `stalwart` | `stalwart` | Mail and collaboration server |
| `victoria-traces` | `victoria-traces` | OpenTelemetry tracing backend |
| `zfs-exporter` | `zfs_exporter` | ZFS Prometheus metrics exporter |

See [CANDIDATES.md](CANDIDATES.md) for the admission rules, equivalent Core
formula names, and projects deferred because of incomplete macOS architecture
coverage or extra kernel/runtime requirements.

## Common operations

```bash
brew update
brew upgrade pgsty/infra/pig pgsty/infra/silo pgsty/infra/alertmanager
brew uninstall pgsty/infra/alertmanager
brew untap pgsty/infra
```

Silo includes an optional Homebrew service:

```bash
brew services start pgsty/infra/silo
brew services stop pgsty/infra/silo
```

Set production credentials before starting Silo. Run
`brew info pgsty/infra/silo` for its data path and service notes.

## Release integrity and updates

- Formulae pin one GitHub Release asset and SHA-256 for each supported OS/CPU pair.
- Draft releases are ignored. Prereleases are ignored except for Farrow, whose
  current `v0.1.0` release is explicitly marked as a prerelease upstream.
- A scheduled updater changes all four platform URLs and hashes atomically and
  opens a reviewable pull request only when versions change.
- Homebrew test-bot checks tap syntax on every push and full install/test behavior
  on pull requests. Automated update branches also dispatch a complete macOS and
  Linux smoke run.

See [CONTRIBUTING.md](CONTRIBUTING.md) for the maintenance workflow and
[SECURITY.md](SECURITY.md) for reporting integrity or security issues.

## Local validation

```bash
brew tap pgsty/infra /absolute/path/to/infra
./scripts/check.sh
```

This checks Ruby syntax, updater invariants, current release metadata, Homebrew
style, and strict online formula audits.
