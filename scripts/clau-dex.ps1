[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("help", "status", "docs", "prompts", "agents")]
    [string]$Command = "help"
)

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptRoot

function Get-RelativeFileList {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return @()
    }

    Get-ChildItem -LiteralPath $Path -Recurse -File |
        ForEach-Object { Resolve-Path -Relative $_.FullName }
}

function Show-Help {
    @(
        "clau-dex CLI shell"
        ""
        "Usage:"
        "  .\scripts\clau-dex.ps1 [help|status|docs|prompts|agents]"
        ""
        "Commands:"
        "  help     Show this command summary"
        "  status   Show the current local bootstrap surface"
        "  docs     List checked-in docs"
        "  prompts  List prompt packs"
        "  agents   List agent definitions"
    ) | Write-Output
}

function Show-Status {
    @(
        "clau-dex bootstrap shell"
        ""
        "Repo root: $RepoRoot"
        "Shell role: local repository orientation and orchestration entry surface"
        "Runtime status: no packaged application runtime is implied"
        ""
        "Key docs:"
        "  docs/PROJECT_CHARTER.md"
        "  docs/OPERATING_MODEL.md"
        "  docs/CLI_FIRST_SHELL.md"
        ""
        "Available prompt packs: $((Get-RelativeFileList -Path (Join-Path $RepoRoot 'prompts')).Count)"
        "Available agent files: $((Get-RelativeFileList -Path (Join-Path $RepoRoot 'agents')).Count)"
    ) | Write-Output
}

function Show-Group {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    Write-Output $Title
    $items = Get-RelativeFileList -Path $Path

    if ($items.Count -eq 0) {
        Write-Output "  (none)"
        return
    }

    $items | ForEach-Object { Write-Output "  $_" }
}

switch ($Command) {
    "help" { Show-Help }
    "status" { Show-Status }
    "docs" { Show-Group -Title "Docs" -Path (Join-Path $RepoRoot "docs") }
    "prompts" { Show-Group -Title "Prompts" -Path (Join-Path $RepoRoot "prompts") }
    "agents" { Show-Group -Title "Agents" -Path (Join-Path $RepoRoot "agents") }
}
