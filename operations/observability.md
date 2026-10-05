# Observabilidad

## Mobile
Crash-free sessions, app start, screen load, offline views, operation result, retry usage.

## API
RPS, p50/p95/p99, 4xx/5xx, auth failures, DB latency, FX dependency latency,
idempotency conflicts.

## Alertas sugeridas
- 5xx > 2% / 5 min.
- p95 > 1.5 s / 10 min.
- FX failures > 20% / 10 min.
- crash-free sessions < 99%.

Nunca registrar PII financiera sensible.
