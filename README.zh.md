# PGSTY Homebrew Tap

[English](README.md) · [PGSTY](https://pgsty.com)

这是 PGSTY 基础设施软件的 Homebrew Tap。所有 Formula 都直接安装由上游
GitHub Release 发布并固定 SHA-256 的二进制制成品，不需要在用户机器上安装
Go、Node.js 或其他编译工具链。

## 安装

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

`pig` 建议始终使用全名 `pgsty/tap/pig`：Homebrew Core 已经有一个 Apache
Pig，而这里的 `pig` 是 PGSTY 的 PostgreSQL 包管理与运维命令行工具。

## 软件清单

| Formula | 安装命令 | 用途 | 发布来源 |
|:--|:--|:--|:--|
| `silo` | `silo` | S3 兼容对象存储服务 | [`pgsty/silo`](https://github.com/pgsty/silo/releases) |
| `mcli` | `mcli` | Silo/S3 命令行客户端 | [`pgsty/mc`](https://github.com/pgsty/mc/releases) |
| `silo-console` | `silo-console` | 对象存储管理控制台 | [`pgsty/silo-console`](https://github.com/pgsty/silo-console/releases) |
| `pig` | `pig` | PostgreSQL 扩展包管理与运维 CLI | [`pgsty/pig`](https://github.com/pgsty/pig/releases) |
| `sow` | `sow` | 本地 RPM/DEB 软件仓库管理器 | [`pgsty/sow`](https://github.com/pgsty/sow/releases) |
| `farrow` | `farrow` | Pigsty 开发虚拟机的原生 QEMU 运行时 | [`pgsty/farrow`](https://github.com/pgsty/farrow/releases) |
| `pg-exporter` | `pg_exporter` | PostgreSQL/PgBouncer Prometheus 监控导出器 | [`pgsty/pg_exporter`](https://github.com/pgsty/pg_exporter/releases) |

支持 Apple Silicon 与 Intel macOS，以及 arm64 与 x86_64 Linux。

## 常用操作

```bash
brew update
brew upgrade pgsty/tap/silo pgsty/tap/mcli pgsty/tap/pig
brew uninstall pgsty/tap/pig
brew untap pgsty/tap
```

Silo 带有可选的 Homebrew 服务定义：

```bash
brew services start pgsty/tap/silo
brew services stop pgsty/tap/silo
```

启动生产服务前请设置安全凭据。`brew info pgsty/tap/silo` 会显示数据目录与
服务说明。

## 发布完整性与自动更新

- 每个 Formula 都分别固定四种 OS/CPU 组合的 Release 资产与 SHA-256。
- 自动更新器忽略 Draft；除 Farrow 外也忽略 prerelease。Farrow 当前的
  `v0.1.0` 在上游明确标记为 prerelease，因此作为已知例外纳入。
- 定时任务以原子方式同时更新四个平台的 URL 与摘要，并创建可审查的 PR。
- Homebrew test-bot 在 PR 上分别验证 macOS 与 Linux 的语法、安装和测试。

维护流程见 [CONTRIBUTING.md](CONTRIBUTING.md)，供应链或安全问题见
[SECURITY.md](SECURITY.md)。

## 本地验收

```bash
brew tap pgsty/tap /absolute/path/to/homebrew-tap
./scripts/check.sh
```

该命令会检查 Ruby 语法、更新器不变量、当前 Release 元数据、Homebrew
风格以及严格在线审计。验证已发布的 GitHub 仓库时可省略路径。
