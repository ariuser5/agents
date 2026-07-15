param(
    [string]$Destination = (Join-Path $HOME ".agents")
)

$ErrorActionPreference = "Stop"
$source = $PSScriptRoot

[void](New-Item -ItemType Directory -Path $Destination -Force)
Copy-Item -LiteralPath (Join-Path $source "global.md") -Destination (Join-Path $Destination "global.md") -Force

foreach ($directory in @("rules", "skills", "adapters")) {
    $target = Join-Path $Destination $directory
    [void](New-Item -ItemType Directory -Path $target -Force)
    Copy-Item -Path (Join-Path $source "$directory\*") -Destination $target -Recurse -Force
}

Write-Host "Agent rules copied to $Destination"
