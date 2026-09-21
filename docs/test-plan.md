# GitOps test plan — gitops-lab project only

## Safety and scope

Use the corrected project-specific authentication in the gitops-lab local CLI
profile. Before each mutation, verify CLI help, project inventory, exact new
names, and the lab selector. Never alter windows, asd, null-destination, or the
existing collector. No automatic rollout. No wildcard applies.

## Phase 2A: concrete proposed Cloud changes

Apply exactly these files, individually, after approval:

1. bindplane/lab/gitops-lab-source.yaml: create gitops-lab-source using syslog:2,
   adapted from the inline source type in windows. UDP 5514, RFC5424, low data
   flow. Intended for synthetic test logs only; no collector attached yet.
2. bindplane/lab/gitops-lab-destination.yaml: create gitops-lab-destination using
   dev_null:1, based on null-destination, narrowed to Logs. No external endpoint
   or credentials; telemetry is discarded locally.
3. bindplane/lab/gitops-lab-fleet.yaml: create gitops-lab-fleet with selector
   gitops-lab-id=gitops-lab-roundtrip-20260921, platform linux and agent type
   bindplane-otel-collector. Leave configuration unassigned. No existing collector
   matches this selector. Fleet apply and empty-fleet acceptance are empirical.

For each file, run `bindplane apply --help`, then use the verified syntax
`bindplane apply -f <EXACT_FILE> --profile gitops-lab`. Check collision before
apply because apply is an upsert. Read back after each create. Stop on rejection
or unexpected behavior. Do not fall back to modifying existing resources.

This first approval excludes configuration creation, assignment, enrollment,
rollout, raw-configuration creation, and all existing-resource edits.

## Prepared configuration draft and next gate

bindplane/lab/gitops-lab-config.yaml defines gitops-lab-config, a Linux modular
configuration referencing only the lab source and destination and using the same
unique selector. It is a REVIEW DRAFT, not approved for apply. The public server
schema exposes startAutomatically, but its standard rollout parameter mapping
must be verified before this file can safely be used. Do not infer that
rollout.disabled disables automatic rollout; these are different concepts.

After verification, finalize a concrete configuration proposal with automatic
rollout explicitly false, then request approval for configuration creation and
fleet assignment. Do not copy the full windows configuration: it includes
Windows-specific sources and assignment state.

## Git and round-trip proof

1. Keep complete existing-resource exports in ignored evidence/private/gitops-lab.
   Review and sanitize lab exports into bindplane/baseline and bindplane/lab.
2. Establish a reviewed Git baseline before the UI edit. No secrets, private
   inventory, local profiles, generated runtime secrets, or collector IDs in Git.
3. Apply lab resources from exact tracked files; compare exported semantic fields.
4. Change one safe field only in the lab configuration UI (for example a source
   display name); keep rollout manual. Export again and review git diff for both
   intended changes and metadata noise. Record actual behavior in results.md.
5. Capture generated OTel separately with `get configurations <NAME> -o raw`.
   Save unreviewed output privately and sanitize before tracking generated YAML.
   Never pass generated OTel YAML to Bindplane resource apply.

## Docker and OpAMP proof (later)

Docker CLI and engine remain unavailable. Resolve installation location/engine,
select a supported image/version, and prepare Compose only after discovering
actual enrollment requirements. Container name gitops-lab-collector. Fresh
identity and runtime state; no host log mounts. Publish any synthetic Syslog
input only on Windows loopback. Enrollment secrets remain local and ignored.

Assign only the new collector to gitops-lab-fleet using the verified label
semantics. Confirm one lab member and zero existing members. Manually start only
gitops-lab-config; check rollout status, expected revision, effective collector
configuration, OpAMP delivery, and acceptance. Never use rollout --all.

## Raw OTel experiment (later)

Reserve gitops-lab-raw-config and a separate file under bindplane/lab for this
test. Begin with a minimal secret-free raw OTel pipeline. Determine whether the
UI offers raw editing, structured components, or a conversion mechanism. Compare
input, exported resource, generated YAML, unsupported fields, and re-export after
UI edits. No general raw-OTel migration command was found in CLI help; supported
migrate-configuration subcommands are Chronicle and Splunk.

## Cleanup

Default Project downloads were removed locally. Future Cloud cleanup requires
an exact list of resources created by this lab; never delete by prefix alone.

## Phase 2A execution status

Completed with user approval. Source, destination, and empty unassigned fleet
created and verified. See results.md for safety checks and export normalization.
Configuration remains a draft and is excluded from any directory-wide apply.
