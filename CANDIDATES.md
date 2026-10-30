# Infra package admission

This file records the 2026-10-27 assessment of the `pgsty/infra-pkg` catalog
for Homebrew distribution. It is an intake boundary, not a permanent blacklist.

## Admission contract

A new Formula is admitted when all of these are true:

1. Upstream publishes a stable, immutable release.
2. The same release has native Darwin and Linux binaries for arm64 and amd64.
3. Every selected asset can be pinned by SHA-256.
4. Homebrew Core does not already package the same project under the same or an
   equivalent name.
5. The binary can be installed and tested without an undisclosed kernel,
   privileged host, or proprietary runtime dependency.

The updater skips Releases with no binary assets, then fails the whole Formula
update if the selected Release is missing any of the four platform assets.
A source archive that could theoretically be cross-compiled is not equivalent
to a published native binary.

On 2026-10-30, `pgbackrest-exporter` remains at v0.24.0: upstream v0.25.0 has no
release attachments. The updater reports the skipped Release and will pick it
up once the complete native binary matrix is available.

A universal macOS archive may serve both Darwin architectures. TigerBeetle's
archive was checked for native arm64 and x86_64 executables; both formula
branches pin the same URL and SHA-256. Linux still requires separate assets.

## Added from infra-pkg

The initial intake adds 20 projects:

`agentsview`, `alertmanager`, `blackbox-exporter`, `headscale`,
`kafka-exporter`, `loki-canary`, `mongodb-exporter`, `mtail`,
`mysqld-exporter`, `nginx-exporter`, `pgbackrest-exporter`, `pgschema`,
`pg-timetable`, `pushgateway`, `redis-exporter`, `sabiql`, `sql-studio`,
`stalwart`, `victoria-traces`, and `zfs-exporter`.

The 2026-10-27 intake adds `kes`, `pgbot`, `pggo`, `pgterm`, and `tigerbeetle`.
`pgterm` depends on `pgbot` for diagnostics. Silo, Silo Console, and the
`pgsty/mc` client (`mcli`) were already present and are refreshed in this batch.

## Already covered by Homebrew

These `infra-pkg` projects have a Homebrew Core Formula or default Cask and are
not duplicated here:

- Core Formulae include `asciinema`, `caddy`, `cloudflared`, `code-server`,
  `dblab`, `duckdb`, `etcd`, `garage`, `golang`, `gost`, `grafana`, `hugo`,
  `juicefs`, `kafka`, `logcli`, `loki`, `nodejs`, `openbao`, `opencode`,
  `opentofu`, `pgstream`, `postgrest`, `prometheus`, `promtail`, `rainfrog`,
  `rclone`, `restic`, `seaweedfs`, `sqlcmd`, `tailcat`, `mcp-toolbox`, `uv`,
  `v2ray`, and `xray`.
- Equivalent Core names cover `node-exporter` as `node_exporter`,
  `victoria-metrics` as `victoriametrics`, and `victoria-logs` as
  `victorialogs`.
- Default Casks cover VS Code, Codex, Claude Code, and their native macOS
  installation paths.
- Crush already documents its maintained upstream Homebrew tap as
  `charmbracelet/tap/crush`.

PGSTY's `pig` remains in this repository despite the Core name collision,
because Core's `pig` is the unrelated Apache Pig project. The fully qualified
name is therefore part of its installation contract.

## Deferred

- `rustfs`, `npgsqlrest`, `pg-hardstorage`, and `vector`: current release assets
  provide Darwin arm64 but not Darwin amd64.
- `timescaledb-event-streamer` and `timescaledb-tools`: current release assets
  provide Darwin amd64 but not Darwin arm64. The tools archive was inspected;
  both `timescaledb-tune` and `timescaledb-parallel-copy` are x86_64 binaries.
- `pgrundev/pgsync`: v0.1.1 is marked prerelease. Core's `pgsync` is the unrelated
  `ankane/pgsync`; it does not cover this project.
- `tigerfs`: native binaries exist, but the FUSE runtime and macOS kernel/system
  extension contract needs a separate installation and CI design.
- `promscale`: upstream is discontinued and the retained release is obsolete.
- Grafana datasource plugins are distributed through Grafana's plugin manager,
  rather than installed as standalone commands.
- Remaining recipes do not currently publish the complete four-platform native
  binary matrix required by this repository.
