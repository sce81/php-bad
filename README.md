# php-bad

Intentionally vulnerable PHP sample for Port / Aikido / Cursor triage demos.

## Branching

Default branch is **`develop`**. Cut `bugfix/<JIRA-KEY>` and other remediation branches from `develop`, then open PRs into `develop`. Do not base autofix work on `main` — that causes merge conflicts with dependency bumps already on `develop`.

## Dependencies

See `composer.json` / `composer.lock` for current pins. Historical demo CVEs used older pins (e.g. `guzzlehttp/psr7@1.8.0`, older `monolog/monolog`); remediations bump those on `bugfix/*` PRs into `develop`.
