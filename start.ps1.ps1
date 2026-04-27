$ErrorActionPreference = "Stop"

$workspace = Split-Path -Parent $MyInvocation.MyCommand.Path
$bundledNode = Join-Path $env:USERPROFILE ".cache\codex-runtimes\codex-primary-runtime\dependencies\node\bin\node.exe"

if (Test-Path -LiteralPath $bundledNode) {
  $node = $bundledNode
} else {
  $nodeCommand = Get-Command node -ErrorAction SilentlyContinue
  if (-not $nodeCommand) {
    throw "Node.js was not found. Install Node.js or run this inside Codex with workspace dependencies installed."
  }
  $node = $nodeCommand.Source
}

Set-Location -LiteralPath $workspace

$portValue = if ($env:PORT) { $env:PORT } else { "3000" }
Write-Host "Starting JusticeBridge MVP in foreground..."
Write-Host "Localhost URL: http://localhost:$portValue"
Write-Host "Press Ctrl+C to stop."

& $node "server.js"
