# Disposable collector plan

Container name: `gitops-lab-collector`. Use a fresh identity and the lab fleet
label `gitops-lab-id=gitops-lab-roundtrip-20260921`. Never reuse the existing
Windows collector identity, runtime directory, or configuration assignment.

Docker remains unavailable in the current shell and standard installation paths.
Image/version and OpAMP enrollment settings must be established before writing a
runnable Compose file. Enrollment secrets belong only in ignored runtime files.
No Docker container has been created.

The planned Syslog input is UDP 5514 in the container. If exposed for a synthetic
PowerShell sender, bind the host port to `127.0.0.1`, not all host interfaces.
Use no Windows host log inputs or host filesystem mounts.
