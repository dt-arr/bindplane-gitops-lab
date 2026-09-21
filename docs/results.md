# Phase 1 results — gitops-lab only

Status: local preparation and read-only discovery complete; configuration apply
is gated on verifying automatic-rollout parameter mapping. No Cloud writes made.

## Environment

- Folder: C:\temp\projects\bindplane-gitops-lab; existing Git repository.
- PowerShell 7.6.5; Git 2.49.0.windows.1 working.
- CLI v1.103.0, installed at %LOCALAPPDATA%\Programs\Bindplane\bindplane.exe.
- Authenticated Cloud requests succeed. Server reports v0.0.0 (not a useful release version).
- Docker command and executable unavailable in checked paths; engine unverified.
- CLI has a Windows log-path error; successful read-only requests still return data.
- Profiles observed: default and gitops-lab. Credential values omitted.

## Verified project inventory

The corrected project-specific key returns the inventory the user independently
confirmed in the gitops-lab UI. The local profile also stores that project's ID.
The earlier key belonged to Default Project; a project override did not change
its scope. Do not rely on a profile name or project flag to override a different
project's key.

| Kind | Count | Names |
| --- | --- | --- |
| Configurations | 1 | windows |
| Standalone sources | 0 | None; windows uses inline sources |
| Processors | 0 | None |
| Destinations | 2 | asd, null-destination |
| Fleets | 0 | None |
| Collectors | 1 | Identifier/name omitted; configuration label windows |
| Agent types | 3 | bindplane-otel-collector, dynatrace-bindplane-otel-collector, observiq-otel-collector |

The windows configuration contains inline bindplane_gateway:1, syslog:2,
netflow:1, and windowsevents_v3:1 sources. Recommend adapting syslog:2 for synthetic
Linux-container logs and creating a lab copy of null-destination (dev_null:1).
Do not copy asd (Chronicle) or use the existing Windows collector.

## Evidence and cleanup

- Removed the earlier Default Project resource lists, collector lists, exports,
  generated YAML, type downloads, and organization project response locally.
- Replaced stale results under evidence/private/gitops-lab with corrected-project
  discovery. Public CLI help and public OpenAPI schema retained.
- Exported windows resource YAML and generated OTel YAML separately into the
  ignored project evidence directory. Generated YAML has receivers, processors,
  connectors, exporters, extensions, and service sections.
- No sensitive exports promoted into tracked directories. No API keys displayed,
  written to discovery files, staged, or committed.
- No resources were imported into Cloud, so there is no Cloud cleanup to perform.
- No new resource name collides with the scoped inventory. The existing collector
  does not match the proposed gitops-lab-id label.

## Remaining empirical checks

Fleet apply support and empty-fleet semantics; configuration reference rendering;
exact standard-rollout parameter mapping for startAutomatically=false; UI edit
and re-export normalization; raw OTel editing limits; Docker image/enrollment and
OpAMP delivery. CLI help establishes syntax, not successful Cloud mutations.

## Concrete next approval

Create only gitops-lab-source (Syslog UDP 5514, RFC5424),
gitops-lab-destination (discard Logs), and gitops-lab-fleet (empty, unassigned,
selector gitops-lab-id=gitops-lab-roundtrip-20260921). See test-plan.md.
Configuration creation, assignment, enrollment, and rollout are excluded from
this first approval because automatic-rollout mapping remains unverified.

## Phase 2A completed

User approved the three exact Cloud creates. Applied each manifest separately
using CLI v1.103.0 with the gitops-lab profile and verified each read-back:

- gitops-lab-source: syslog:2; UDP 5514, RFC5424, low data flow.
- gitops-lab-destination: dev_null:1; Logs only, drop_raw_copy=true.
- gitops-lab-fleet: Linux / bindplane-otel-collector; unique lab selector;
  configuration unassigned. Selector query returned zero collectors.

Existing windows configuration and both pre-existing destination specifications
and versions are unchanged. The single existing collector retains its identity,
labels, and windows assignment. No configuration created, collector enrolled,
configuration assigned, or rollout started. No automatic rollout enabled.

Empirical findings: generic apply supports creating an empty Fleet without a
configuration. Export succeeds for Source, Destination, and Fleet. Export strips
type-version suffixes (syslog:2 -> syslog, dev_null:1 -> dev_null) and expands
source defaults. Thus export is not byte-identical to the input manifest and a
blind reapply of exported files would lose explicit type-version pinning.

Reviewed, secret-free exports are saved in bindplane/baseline. Intended manifests
remain in bindplane/lab with pinned type versions. Full mutation/read-back and
before/after evidence remain ignored in evidence/private/gitops-lab. Git staging
and committing have not been performed; a committed baseline for the later UI
round-trip demonstration is still pending.
