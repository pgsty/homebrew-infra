# PGSTY Infra

[English](README.md) · [PGSTY](https://pgsty.com)

这是 PGSTY 与基础设施软件的 Homebrew 二进制仓库。所有 Formula 都分别固定
Apple Silicon、Intel macOS、arm64 Linux 与 x86_64 Linux 的上游原生制成品和
SHA-256，不需要在用户机器上安装 Go、Rust、Node.js 或其他编译工具链。

## 安装

源码仓库按要求命名为 `pgsty/infra`，而不是 `pgsty/homebrew-infra`，所以首次
添加 Tap 时必须显式写出 URL：

```bash
brew tap pgsty/infra https://github.com/pgsty/infra

brew install pgsty/infra/pig
brew install pgsty/infra/silo
brew install pgsty/infra/alertmanager
brew install pgsty/infra/pgschema
```

与 Homebrew Core 重名的软件应始终使用全名。尤其是 `pgsty/infra/pig` 代表
PGSTY PostgreSQL CLI，而 Core 中的 `pig` 是 Apache Pig。

已有的 `pgsty/tap` 安装会通过 GitHub 仓库重定向继续工作；新安装和文档统一
使用 `pgsty/infra` 作为规范名称。

## PGSTY 软件

| Formula | 安装命令 | 用途 | 发布来源 |
|:--|:--|:--|:--|
| `farrow` | `farrow` | Pigsty 开发虚拟机的原生 QEMU 运行时 | [`pgsty/farrow`](https://github.com/pgsty/farrow/releases) |
| `mcli` | `mcli` | Silo/S3 命令行客户端 | [`pgsty/mc`](https://github.com/pgsty/mc/releases) |
| `pg-exporter` | `pg_exporter` | PostgreSQL/PgBouncer Prometheus 监控导出器 | [`pgsty/pg_exporter`](https://github.com/pgsty/pg_exporter/releases) |
| `pig` | `pig` | PostgreSQL 扩展包管理与运维 CLI | [`pgsty/pig`](https://github.com/pgsty/pig/releases) |
| `silo` | `silo` | S3 兼容对象存储服务 | [`pgsty/silo`](https://github.com/pgsty/silo/releases) |
| `silo-console` | `silo-console` | 对象存储管理控制台 | [`pgsty/silo-console`](https://github.com/pgsty/silo-console/releases) |
| `sow` | `sow` | 本地 RPM/DEB 软件仓库管理器 | [`pgsty/sow`](https://github.com/pgsty/sow/releases) |

## 额外基础设施软件

以下项目来自 [`pgsty/infra-pkg`](https://github.com/pgsty/infra-pkg) 清单，均在
同一稳定 Release 中提供四种受支持的 OS/CPU 原生制成品，并且没有被 Homebrew
Core 以同一项目覆盖。

| Formula | 安装命令 | 用途 |
|:--|:--|:--|
| `agentsview` | `agentsview` | 查看 AI 编程代理会话与成本 |
| `alertmanager` | `alertmanager`, `amtool` | Prometheus 告警路由与管理 |
| `blackbox-exporter` | `blackbox_exporter` | HTTP、DNS、TCP、ICMP 与 gRPC 探测 |
| `headscale` | `headscale` | 自托管 Tailscale 控制服务 |
| `kafka-exporter` | `kafka_exporter` | Kafka Prometheus 指标导出器 |
| `loki-canary` | `loki-canary` | Loki 端到端可用性验证器 |
| `mongodb-exporter` | `mongodb_exporter` | MongoDB Prometheus 指标导出器 |
| `mtail` | `mtail` | 从应用日志中提取指标 |
| `mysqld-exporter` | `mysqld_exporter` | MySQL Prometheus 指标导出器 |
| `nginx-exporter` | `nginx_exporter` | NGINX Prometheus 指标导出器 |
| `pgbackrest-exporter` | `pgbackrest_exporter` | pgBackRest Prometheus 指标导出器 |
| `pgschema` | `pgschema` | PostgreSQL 声明式 Schema 迁移工具 |
| `pg-timetable` | `pg_timetable` | PostgreSQL 作业调度器 |
| `pushgateway` | `pushgateway` | 短生命周期任务的 Prometheus 网关 |
| `redis-exporter` | `redis_exporter` | Redis Prometheus 指标导出器 |
| `sabiql` | `sabiql` | PostgreSQL 终端客户端 |
| `sql-studio` | `sql-studio` | 多数据库终端 SQL 浏览器 |
| `stalwart` | `stalwart` | 邮件与协作服务器 |
| `victoria-traces` | `victoria-traces` | OpenTelemetry 链路追踪后端 |
| `zfs-exporter` | `zfs_exporter` | ZFS Prometheus 指标导出器 |

准入标准、Homebrew Core 等价名称以及因 macOS 架构不完整或额外内核/运行时依赖
而暂缓的项目，详见 [CANDIDATES.md](CANDIDATES.md)。

## 常用操作

```bash
brew update
brew upgrade pgsty/infra/pig pgsty/infra/silo pgsty/infra/alertmanager
brew uninstall pgsty/infra/alertmanager
brew untap pgsty/infra
```

Silo 带有可选的 Homebrew 服务定义：

```bash
brew services start pgsty/infra/silo
brew services stop pgsty/infra/silo
```

启动生产服务前请设置安全凭据。`brew info pgsty/infra/silo` 会显示数据目录与
服务说明。

## 发布完整性与自动更新

- 每个 Formula 都分别固定四种 OS/CPU 组合的 Release 资产与 SHA-256。
- 自动更新器忽略 Draft；除 Farrow 外也忽略 prerelease。Farrow 当前的
  `v0.1.0` 在上游明确标记为 prerelease，因此作为已知例外纳入。
- 定时任务以原子方式同时更新四个平台的 URL 与摘要，仅在版本变化时创建 PR。
- Homebrew test-bot 在每次推送时检查 Tap 语法，在 PR 上执行完整安装测试；
  自动更新分支还会触发覆盖全部 Formula 的 macOS/Linux 冒烟测试。

维护流程见 [CONTRIBUTING.md](CONTRIBUTING.md)，供应链或安全问题见
[SECURITY.md](SECURITY.md)。

## 本地验收

```bash
brew tap pgsty/infra /absolute/path/to/infra
./scripts/check.sh
```

该命令会检查 Ruby 语法、更新器不变量、当前 Release 元数据、Homebrew 风格
以及严格在线审计。
