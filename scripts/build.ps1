[CmdletBinding()]
param(
    [string]$EnginePath,
    [string]$BundleUrl = 'https://data1b.fullyjustified.net/tlextras-2022.0r0.tar'
)
$ErrorActionPreference = 'Stop'
$taskLatexRoot = Split-Path -Parent $PSScriptRoot
$taskProjectRoot = Split-Path -Parent $taskLatexRoot
$taskBuildDir = Join-Path $taskLatexRoot 'build'
$taskOutputDir = Join-Path $taskLatexRoot 'output'
$taskCacheDir = Join-Path $taskProjectRoot 'tmp/latex-tools/cache'
New-Item -ItemType Directory -Force -Path $taskBuildDir,$taskOutputDir,$taskCacheDir | Out-Null
if (-not $EnginePath) {
    foreach ($taskEngineName in @('xelatex','tectonic')) {
        $taskFoundEngine = Get-Command $taskEngineName -ErrorAction SilentlyContinue
        if ($taskFoundEngine) { $EnginePath = $taskFoundEngine.Source; break }
    }
}
if (-not $EnginePath) {
    $taskToolsDir = Join-Path $taskProjectRoot 'tmp/latex-tools'
    if (Test-Path -LiteralPath $taskToolsDir) {
        $taskPortableEngine = Get-ChildItem -LiteralPath $taskToolsDir -Filter 'tectonic.exe' -File -Recurse | Select-Object -First 1
        if ($taskPortableEngine) { $EnginePath = $taskPortableEngine.FullName }
    }
}
if (-not $EnginePath -or -not (Test-Path -LiteralPath $EnginePath)) {
    throw 'No XeLaTeX or Tectonic found. Supply -EnginePath with the compiler executable.'
}
$taskOldCache = $env:TECTONIC_CACHE_DIR
$taskOldFontConfig = $env:FONTCONFIG_FILE
$taskFontConfig = Join-Path $taskProjectRoot 'tmp/latex-tools/fonts.conf'
Push-Location -LiteralPath $taskLatexRoot
try {
    $env:TECTONIC_CACHE_DIR = $taskCacheDir
    if (Test-Path -LiteralPath $taskFontConfig) { $env:FONTCONFIG_FILE = $taskFontConfig }
    if ([IO.Path]::GetFileNameWithoutExtension($EnginePath) -eq 'tectonic') {
        & $EnginePath -X compile --bundle $BundleUrl --keep-logs --keep-intermediates --outdir $taskBuildDir 'main.tex'
        if ($LASTEXITCODE -ne 0) { throw "Tectonic failed with exit code $LASTEXITCODE" }
    } else {
        foreach ($taskPass in 1..2) {
            & $EnginePath '-interaction=nonstopmode' '-halt-on-error' '-file-line-error' "-output-directory=$taskBuildDir" 'main.tex'
            if ($LASTEXITCODE -ne 0) { throw "XeLaTeX pass $taskPass failed with exit code $LASTEXITCODE" }
        }
    }
    $taskPdf = Join-Path $taskBuildDir 'main.pdf'
    if (-not (Test-Path -LiteralPath $taskPdf)) { throw 'Compiler did not generate main.pdf.' }
    $taskFinalPdf = Join-Path $taskOutputDir 'solution-draft.pdf'
    Copy-Item -LiteralPath $taskPdf -Destination $taskFinalPdf -Force
    Write-Output "PDF ready: $taskFinalPdf"
} finally {
    $env:TECTONIC_CACHE_DIR = $taskOldCache
    $env:FONTCONFIG_FILE = $taskOldFontConfig
    Pop-Location
}
