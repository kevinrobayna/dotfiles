---
name: datadog-troubleshooting
description: Troubleshoot application issues using Datadog via the pup CLI. Investigate errors, performance problems, and service health by correlating logs, traces, metrics, monitors, and incidents.
allowed-tools: Bash(pup logs:*), Bash(pup traces:*), Bash(pup metrics query:*), Bash(pup metrics list:*), Bash(pup metrics search:*), Bash(pup monitors list:*), Bash(pup monitors get:*), Bash(pup monitors search:*), Bash(pup events list:*), Bash(pup events search:*), Bash(pup events get:*), Bash(pup incidents list:*), Bash(pup incidents get:*), Bash(pup slos list:*), Bash(pup slos get:*), Bash(pup slos status:*), Bash(pup apm:*), Bash(pup auth status)
---

# Datadog Troubleshooting

Investigate application issues by correlating signals across logs, traces, metrics, monitors, and incidents using the `pup` CLI. All commands are read-only.

## Prerequisites

Authenticate with `pup auth login` before using this skill. Check status with `pup auth status`.

## Troubleshooting Workflow

Follow this structured investigation process:

### 1. Understand the symptoms

Ask: What is the problem? When did it start? Which service/environment?

### 2. Check for active incidents and alerting monitors

```bash
pup incidents list --limit=10
pup monitors search --query="status:Alert OR status:Warn"
pup monitors list --tags="env:production" --limit=50
```

### 3. Search logs for errors

```bash
pup logs aggregate --query="status:error service:<service>" --from=1h --compute=count --group-by=service
pup logs search --query="status:error service:<service>" --from=1h --limit=20
```

### 4. Search traces for performance issues and errors

```bash
pup traces search --query="service:<service> status:error" --from=1h --limit=20
pup traces aggregate --query="service:<service>" --from=1h --compute="avg(@duration)" --group-by=resource_name
```

### 5. Query metrics for anomalies

```bash
pup metrics query --query="avg:trace.servlet.request.duration{service:<service>,env:prod} by {resource_name}" --from=1h
pup metrics query --query="sum:trace.servlet.request.errors{service:<service>,env:prod} by {resource_name}" --from=1h
```

### 6. Check SLOs

```bash
pup slos list
pup slos status <slo_id>
```

### 7. Correlate findings

Cross-reference timestamps and services across logs, traces, and metrics to identify root cause. Look for:

- Error spikes at the same time across services
- Latency increases preceding errors
- Upstream dependency failures

## pup CLI Reference (Read-Only)

### Logs

```bash
# Search logs (v1 API) - good for fetching individual log entries
pup logs search --query="<query>" --from=1h --limit=50

# Query logs (v2 API) - more features, supports timezone
pup logs query --query="<query>" --from=1h --limit=50

# Aggregate logs - use for counts and distributions (NOT raw log fetching)
pup logs aggregate --query="<query>" --from=1h --compute=count --group-by=<field>

# List recent logs
pup logs list --query="<query>" --from=1h --limit=10
```

### Traces

```bash
# Search spans
pup traces search --query="<query>" --from=1h --limit=50

# Aggregate span stats
pup traces aggregate --query="<query>" --from=1h --compute="avg(@duration)" --group-by=service
```

### Metrics

```bash
# Query time-series data
pup metrics query --query="<aggregation>:<metric>{<filter>} by {<group>}" --from=1h

# List available metrics
pup metrics list --filter="<pattern>" --from=1h

# Search metrics (v1 API)
pup metrics search --query="<query>" --from=1h
```

### Monitors

```bash
# List monitors with filters
pup monitors list --tags="env:production" --name="<substring>" --limit=200

# Search monitors (full-text)
pup monitors search --query="status:Alert" --per-page=30

# Get monitor details
pup monitors get <monitor_id>
```

### Events

```bash
# List recent events
pup events list --from=1h --filter="<query>" --tags="<tags>"

# Search events
pup events search --query="<query>" --from=1h --limit=100
```

### Incidents

```bash
# List incidents
pup incidents list --limit=50

# Get incident details
pup incidents get <incident_id>
```

### SLOs

```bash
# List all SLOs
pup slos list

# Get SLO details
pup slos get <slo_id>

# Get SLO status with time range
pup slos status <slo_id> --from=7d
```

### APM Services

```bash
# List services
pup apm services list --env=<env>

# Service performance stats
pup apm services stats --env=<env>

# Service operations
pup apm services operations --service=<name> --env=<env>

# Service resources (endpoints)
pup apm services resources --service=<name> --operation=<op> --env=<env>

# Service dependencies
pup apm dependencies list --env=<env>

# Service flow map
pup apm flow-map --query="service:<name>" --env=<env>

# APM entities
pup apm entities list --env=<env> --limit=50
```

## Query Syntax

### Log queries

`status:error`, `service:web-app`, `@attr:val`, `host:i-*`, `"exact phrase"`, `AND`/`OR`/`NOT` operators, `-status:info` (negation), wildcards with `*`.

### Trace queries

`service:<name>`, `resource_name:<path>`, `@duration:>5s` (shorthand), `status:error`, `operation_name:<op>`, `env:production`.

### Metric queries

Format: `<aggregation>:<metric_name>{<filter>} by {<group>}`

Example: `avg:system.cpu.user{env:prod} by {host}`

Aggregations: `avg`, `sum`, `min`, `max`, `count`.

### Monitor search queries

Use `--name` for substring search, `--tags` for tag filtering (comma-separated). Use `--query` for full-text: `status:Alert`, `status:Warn`, `type:metric`.

### Time formats

- Relative: `5s`, `30m`, `1h`, `4h`, `1d`, `7d`, `30d`
- Absolute: Unix timestamp in milliseconds, RFC3339 (`2024-01-01T00:00:00Z`)
- Examples: `--from=1h`, `--from=30m --to=now`, `--from=7d --to=1d`

## Anti-Patterns

- **Always specify `--from`** on time-series queries to avoid unexpected time ranges
- **Start with small limits** (`--limit=20`), don't jump to `--limit=1000`
- **Don't list all monitors without filters** in large organizations (>10k monitors)
- **APM durations are NANOSECONDS**: 1 second = 1,000,000,000, 5ms = 5,000,000
- **Use `logs aggregate --compute=count`** for counting, not raw log fetching
- **Don't use `--from=30d`** unless you specifically need a month of data (slow)
- **Check errors before retrying**: 401 = re-authenticate, 403 = missing permissions
- **Always specify an aggregation** for `metrics query` (avg, sum, max, min, count)
- **Use query filters at the API level** instead of piping large JSON through jq

## Common Investigation Workflows

### Error investigation

```bash
pup logs aggregate --query="status:error" --from=1h --compute=count --group-by=service
pup logs search --query="status:error service:<top_service>" --from=1h --limit=20
pup monitors search --query="status:Alert"
```

### Performance investigation

```bash
pup metrics query --query="avg:trace.servlet.request.duration{env:prod} by {service}" --from=1h
pup traces aggregate --query="service:<service>" --from=1h --compute="percentile(@duration,99)" --group-by=resource_name
pup traces search --query="service:<service> @duration:>5s" --from=1h --limit=20
```

### Monitor status check

```bash
pup monitors list --tags="env:production" --limit=200
pup monitors search --query="status:Alert OR status:Warn"
pup monitors get <monitor_id>
```

### Service health overview

```bash
pup slos list
pup monitors list --tags="team:<team_name>"
pup incidents list --limit=10
pup apm services stats --env=production
```
