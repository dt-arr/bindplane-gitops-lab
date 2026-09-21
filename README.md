# Bindplane GitOps lab

Isolated Windows / PowerShell lab for https://app.bindplane.com.

Phase 1 is local preparation and read-only discovery. Cloud mutations require
approval of concrete, reviewed Phase 2 resources. Nothing has been applied.

See [test plan](docs/test-plan.md), [results](docs/results.md), and
[verified commands](docs/cli-commands.md).

All new resources must start with `gitops-lab-`. Existing resources and collectors
must never be modified, reassigned, or rolled out. Automatic rollout must stay off.
Only a newly created disposable Docker collector may join the lab fleet.

Never put API keys in chat or this repository. Enter authentication directly in
your local terminal. Local CLI profiles are outside the repository and excluded
from Git. Detailed discovery belongs only in ignored `evidence/private/`.
Exports can contain credentials: review and sanitize before placing them in a
tracked directory. Do not stage or commit unreviewed exports or generated YAML.

Directory layout:

- `bindplane/baseline/`: reviewed, sanitized baseline resource exports.
- `bindplane/lab/`: reviewed Bindplane resource manifests, pending discovery.
- `bindplane/generated-otel/`: sanitized generated OTel configuration, separate from resource manifests.
- `docker/`: disposable collector definition, pending engine and type discovery.
- `scripts/`: local PowerShell helpers.
- `evidence/private/`: ignored detailed discovery and temporary raw exports.

No Git commit is created automatically.
