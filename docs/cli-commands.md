# Installed CLI capabilities

Verified from local CLI v1.103.0 help on 2026-09-21; help support is not proof of
server permission or behavior. Use the installed executable at
`$env:LOCALAPPDATA\Programs\Bindplane\bindplane.exe` if it is not on PATH.
Every future invocation must first check the relevant installed subcommand help.

Project scope is now verified against the user's UI: one collector and windows configuration. The earlier key belonged to Default Project; project flags did not override its scope. Use only the corrected gitops-lab authentication.

| Purpose | Supported syntax / remaining verification |
| --- | --- |
| Version | `bindplane version --profile gitops-lab` |
| Local profile | `bindplane profile set gitops-lab --remote-url https://app.bindplane.com --api-key <API_KEY>`; `--project <PROJECT_ID>` supported for project-scoped authentication |
| Profile list | `bindplane profile list`; do not display raw profile details before verifying masking |
| Discovery | `bindplane get configurations`, `sources`, `processors`, `destinations`, `fleets`, `collectors`, `agent-types`; append `--profile gitops-lab -o json` |
| Pagination | Configurations, fleets, collectors expose `--limit` and `--offset`; default limit 100. Enumerate every page |
| Resource export | `bindplane get configurations <NAME> --export -o yaml --profile gitops-lab`; sources, processors, destinations have the same export flag |
| Fleet export | `bindplane get fleets <NAME> --export -o yaml --profile gitops-lab`; inherited export flag, actual round-trip pending |
| Apply | `bindplane apply -f <FILE> --profile gitops-lab`; file/directory/glob/stdin supported. Use exact reviewed lab files only |
| Copy | `bindplane copy config <ORIGINAL> <NEW>` shown in parent help; `copy configuration` is supported, but child usage omits arguments. Cloud behavior pending |
| Fleet creation | No dedicated fleet creation command established. Generic apply exists; live public OpenAPI defines Fleet spec.configuration (unversioned configuration name) and spec.selector.matchLabels. Apply acceptance remains empirical |
| Labels | `bindplane label <TYPE> <NAME_OR_ID> <KEY=VALUE> --profile gitops-lab`; collector token and fleet label semantics need verification |
| Manual rollout | `bindplane rollout start <CONFIGURATION> --profile gitops-lab`; flags include initial, max, max-errors, multiplier. Never use `--all` |
| Rollout status | `bindplane rollout status <CONFIGURATION> --profile gitops-lab` |
| Generated OTel | `bindplane get configurations windows -o raw --profile gitops-lab` successfully returned generated OTel YAML; captured privately |
| Raw OTel import | `migrate-configuration` lists Chronicle and Splunk only. No general OTel-to-structured-resource importer established |

Reference consulted: https://docs.bindplane.com/cli-and-api/cli/reference . Installed
help takes precedence over documentation.

