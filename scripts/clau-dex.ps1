[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("help", "status", "docs", "prompts", "agents", "rules", "scaffold-agent", "new-agent")]
    [string]$Command = "help"
,
    [Parameter(Position = 1)]
    [string]$Name
)

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $ScriptRoot
$AgentsRoot = Join-Path $RepoRoot "agents"
$SuperAgentsRoot = Join-Path $AgentsRoot "super-agents"
$DocsRoot = Join-Path $RepoRoot "docs"
$PromptsRoot = Join-Path $RepoRoot "prompts"
$VisibleCommands = @("help", "status", "docs", "prompts", "agents", "rules", "scaffold-agent")

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

function ConvertTo-Slug {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    $slug = $Value.Trim().ToLowerInvariant()
    $slug = [Regex]::Replace($slug, "[^a-z0-9]+", "-")
    $slug = $slug.Trim("-")

    return $slug
}

function Show-Help {
    $commandLines = @(
        "  help            Show this command summary"
        "  status          Show the current executable repository surface"
        "  docs            List checked-in docs"
        "  prompts         List prompt packs"
        "  agents          List agent definitions"
        "  rules           Print the current operating rules summary"
        "  scaffold-agent  Scaffold a focused agent prompt in agents/super-agents/"
    )

    @(
        "clau-dex CLI shell"
        ""
        "Usage:"
        "  .\scripts\clau-dex.ps1 scaffold-agent <name>"
        "  .\scripts\clau-dex.ps1 [help|status|docs|prompts|agents|rules]"
        ""
        "Commands:"
    ) + $commandLines + @(
        ""
        "Compatibility:"
        "  new-agent is kept as an alias for scaffold-agent"
    ) | Write-Output
}

function Show-Status {
    $docFiles = Get-RelativeFileList -Path $DocsRoot
    $promptFiles = Get-RelativeFileList -Path $PromptsRoot
    $agentFiles = Get-RelativeFileList -Path $AgentsRoot

    @(
        "clau-dex executable surface"
        ""
        "Repo root: $RepoRoot"
        "Shell path: .\scripts\clau-dex.ps1"
        "Shell role: local-first repository helper with one narrow orchestration action"
        "Runtime status: no packaged app runtime, dependency manager, or external integration is present"
        ""
        "Commands:"
        "  $($VisibleCommands -join ', ')"
        ""
        "Checked-in surface:"
        "  Docs: $($docFiles.Count) file(s)"
        "  Prompt packs: $($promptFiles.Count) file(s)"
        "  Agent definitions: $($agentFiles.Count) file(s)"
        ""
        "Orchestration slice:"
        "  scaffold-agent creates a focused agent prompt markdown file under agents/super-agents/"
        "  new-agent remains available as a compatibility alias"
        ""
        "Still out of scope:"
        "  No network behavior"
        "  No API integration"
        "  No test harness or CI"
        "  No implementation runtime in src/"
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

function Show-Rules {
    @(
        "clau-dex operating rules summary"
        ""
        "Source docs:"
        "  AGENTS.md"
        "  docs/OPERATING_MODEL.md"
        "  docs/CLI_FIRST_SHELL.md"
        ""
        "Repository rules:"
        "  Treat the checked-in repo as the source of truth."
        "  Keep changes narrow, local-first, and honest about current capabilities."
        "  Do not imply a packaged runtime, hosted service, or dependency stack that is not checked in."
        ""
        "Decision flow:"
        "  CLAU-DEX PRIME decides direction first."
        "  Codex executes repo changes after scope, constraints, and verification are clear."
        "  Checkpoint work in small, reviewable conventional-commit slices."
        ""
        "Shell boundaries:"
        "  Use this shell for local inspection and small orchestration helpers."
        "  Do not treat it as an application runtime or remote agent manager."
        ""
        "Verification standard:"
        "  Record manual verification steps with each meaningful change."
    ) | Write-Output
}

function New-AgentScaffold {
    param(
        [string]$AgentName
    )

    if ([string]::IsNullOrWhiteSpace($AgentName)) {
        throw "scaffold-agent requires a name. Example: .\scripts\clau-dex.ps1 scaffold-agent repo-checker"
    }

    $slug = ConvertTo-Slug -Value $AgentName

    if ([string]::IsNullOrWhiteSpace($slug)) {
        throw "The supplied agent name must contain letters or numbers."
    }

    $targetPath = Join-Path $SuperAgentsRoot "$slug.md"

    if (Test-Path -LiteralPath $targetPath) {
        throw "Agent scaffold already exists: $targetPath"
    }

    if (-not (Test-Path -LiteralPath $SuperAgentsRoot)) {
        New-Item -ItemType Directory -Path $SuperAgentsRoot -Force | Out-Null
    }

    $title = ($slug -split "-") | ForEach-Object {
        if ($_.Length -gt 0) {
            $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1)
        }
    }

    $content = @(
        "# Super-Agent: $($title -join ' ')"
        ""
        "## Purpose"
        "Define the specific job this focused agent should handle inside `clau-dex`."
        ""
        "## Best Used For"
        "- one repeated repo task"
        "- one narrow planning or review lane"
        "- one clear output shape"
        ""
        "## Default Tasks"
        "- inspect the local repo state relevant to the task"
        "- apply the stated constraints before suggesting action"
        "- produce a small, reviewable result"
        ""
        "## Boundaries"
        "- do not imply capabilities that are not checked in"
        "- do not widen scope beyond the stated task"
        "- keep the workflow local-first and clean-room"
        ""
        "## Expected Output"
        "Produce:"
        "1. a concise task result matched to the agent purpose"
        "2. explicit assumptions or limits when they matter"
        "3. manual verification notes when a repo change is proposed"
        ""
        "## Clean-Room Reminder"
        "Write original material grounded in this repository and user-provided context."
    )

    Set-Content -LiteralPath $targetPath -Value $content

    @(
        "Created agent scaffold:"
        "  $(Resolve-Path -Relative $targetPath)"
        ""
        "Next step:"
        "  Edit the Purpose, Best Used For, and Boundaries sections for the specific role."
    ) | Write-Output
}

switch ($Command) {
    "new-agent" { New-AgentScaffold -AgentName $Name }
    "help" { Show-Help }
    "status" { Show-Status }
    "docs" { Show-Group -Title "Docs" -Path $DocsRoot }
    "prompts" { Show-Group -Title "Prompts" -Path $PromptsRoot }
    "agents" { Show-Group -Title "Agents" -Path $AgentsRoot }
    "rules" { Show-Rules }
    "scaffold-agent" { New-AgentScaffold -AgentName $Name }
}
