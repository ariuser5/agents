[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$Destination = (Join-Path $HOME ".agents")
)

$ErrorActionPreference = "Stop"
$source = $PSScriptRoot
$destinationFull = [System.IO.Path]::GetFullPath($Destination)
$manifest = Join-Path $source "managed-files.txt"

if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
    throw "Deployment allowlist is missing: $manifest"
}

$destinationItem = Get-Item -LiteralPath $destinationFull -Force -ErrorAction SilentlyContinue
if ($null -ne $destinationItem -and -not $destinationItem.PSIsContainer) {
    throw "Destination exists but is not a directory: $destinationFull"
}

$files = @()
foreach ($line in Get-Content -LiteralPath $manifest) {
    $relativePath = $line.Trim()
    if ([string]::IsNullOrEmpty($relativePath)) {
        continue
    }
    if (
        [System.IO.Path]::IsPathRooted($relativePath) -or
        $relativePath.Contains("\") -or
        $relativePath.Contains(":") -or
        $relativePath -match "(^|/)\.\.?($|/)"
    ) {
        throw "Unsafe deployment path in managed-files.txt: $relativePath"
    }

    $nativePath = $relativePath.Replace("/", [System.IO.Path]::DirectorySeparatorChar)
    $sourcePath = Join-Path $source $nativePath
    $targetPath = Join-Path $destinationFull $nativePath
    if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
        throw "Managed source file is missing: $sourcePath"
    }
    if (Test-Path -LiteralPath $targetPath -PathType Container) {
        throw "A directory blocks a managed file target: $targetPath"
    }
    $files += [pscustomobject]@{ Source = $sourcePath; Target = $targetPath }
}

if ($files.Count -eq 0) {
    throw "Deployment allowlist is empty: $manifest"
}

foreach ($file in $files) {
    if ($PSCmdlet.ShouldProcess($file.Target, "Copy managed file")) {
        [void](New-Item -ItemType Directory -Path (Split-Path -Parent $file.Target) -Force)
        Copy-Item -LiteralPath $file.Source -Destination $file.Target -Force
    }
}

$verb = if ($WhatIfPreference) { "previewed" } else { "completed" }
Write-Host "Agent library deployment $verb for $destinationFull ($($files.Count) files)."
Write-Host "Unlisted files and product configuration were left untouched."
