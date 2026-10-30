# php-bad

Intentionally vulnerable PHP sample for Port / Aikido / Cursor triage demos.

Pins `guzzlehttp/psr7@1.8.0`, which is affected by CVE-2023-29197 (HTTP header injection). Upgrade to `>=1.9.1` or `>=2.4.5`.
