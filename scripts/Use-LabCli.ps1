# Dot-source to expose the locally installed CLI in this PowerShell session only.
# Usage: . .\scripts\Use-LabCli.ps1
$labCliDirectory = Join-Path $env:LOCALAPPDATA 'Programs\Bindplane'
if (-not (Test-Path (Join-Path $labCliDirectory 'bindplane.exe'))) {
    throw 'Bindplane executable not found in the lab installation directory.'
}
if ($labCliDirectory -notin ($env:PATH -split ';')) {
    $env:PATH = "$labCliDirectory;$env:PATH"
}
