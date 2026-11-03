# php-bad

Intentionally vulnerable PHP sample for Port / Aikido / Cursor triage demos.

Pins `guzzlehttp/psr7@1.9.1` (remediates CVE-2023-29197 HTTP header injection; fixed in `>=1.9.1` / `>=2.4.5`).

## Port callback (GitHub Actions)

On merge of a PR into `develop`, `.github/workflows/port-jira-close-on-merge.yml` extracts a Jira key from the branch/title/body and triggers Port workflow `jira_close_on_pr_merged`.

Required repository secrets:

- `PORT_CLIENT_ID`
- `PORT_CLIENT_SECRET`

Optional repository variable:

- `PORT_API_URL` (defaults to `https://api.port.io`)
