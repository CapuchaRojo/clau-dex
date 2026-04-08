[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("help", "status", "audit", "docs", "prompts", "agents", "rules", "scaffold-agent", "new-agent")]
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
$ScriptsRoot = Join-Path $RepoRoot "scripts"
$SrcRoot = Join-Path $RepoRoot "src"
$VisibleCommands = @("help", "status", "audit", "docs", "prompts", "agents", "rules", "scaffold-agent")

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
        "  audit           Check the narrow bootstrap repository invariants"
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
        "  .\scripts\clau-dex.ps1 [help|status|audit|docs|prompts|agents|rules]"
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
        "Shell role: local-first repository helper with one narrow orchestration action and one narrow bootstrap audit"
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
        "  audit checks a small hardcoded bootstrap-state surface"
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

function Add-AuditResult {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results,
        [Parameter(Mandatory = $true)]
        [ValidateSet("PASS", "WARN", "FAIL")]
        [string]$Level,
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $Results.Add([pscustomobject]@{
        Level = $Level
        Message = $Message
    })
}

function Test-RepoPath {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results,
        [Parameter(Mandatory = $true)]
        [string]$RelativePath,
        [switch]$Directory
    )

    $fullPath = Join-Path $RepoRoot $RelativePath
    $exists = if ($Directory) {
        Test-Path -LiteralPath $fullPath -PathType Container
    }
    else {
        Test-Path -LiteralPath $fullPath -PathType Leaf
    }

    if ($exists) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "$RelativePath exists"
        return
    }

    Add-AuditResult -Results $Results -Level "FAIL" -Message "$RelativePath is missing"
}

function Test-ForbiddenFilesAbsent {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results,
        [Parameter(Mandatory = $true)]
        [string[]]$RelativePaths,
        [Parameter(Mandatory = $true)]
        [string]$Label
    )

    $found = @(
        foreach ($relativePath in $RelativePaths) {
            $fullPath = Join-Path $RepoRoot $relativePath

            if (Test-Path -LiteralPath $fullPath) {
                $relativePath
            }
        }
    )

    if ($found.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "$Label absent"
        return
    }

    Add-AuditResult -Results $Results -Level "FAIL" -Message "$Label present: $($found -join ', ')"
}

function Show-Audit {
    $results = [System.Collections.Generic.List[pscustomobject]]::new()

    $requiredFiles = @(
        "README.md",
        "AGENTS.md",
        ".codex/config.toml",
        "scripts/clau-dex.ps1",
        "scripts/README.md",
        "docs/BOOTSTRAP_PLAN.md",
        "docs/REPOSITORY_ARCHITECTURE.md",
        "docs/CLI_FIRST_SHELL.md",
        "src/README.md"
    )

    $requiredDirectories = @(
        "docs",
        "agents",
        "agents/super-agents",
        "prompts",
        "prompts/chatgpt",
        "prompts/codex",
        "scripts",
        "src"
    )

    foreach ($relativePath in $requiredFiles) {
        Test-RepoPath -Results $results -RelativePath $relativePath
    }

    foreach ($relativePath in $requiredDirectories) {
        Test-RepoPath -Results $results -RelativePath $relativePath -Directory
    }

    $srcFiles = @()

    if (Test-Path -LiteralPath $SrcRoot -PathType Container) {
        $srcFiles = @(Get-ChildItem -LiteralPath $SrcRoot -File | Select-Object -ExpandProperty Name)
    }

    if (($srcFiles.Count -eq 1) -and ($srcFiles[0] -eq "README.md")) {
        Add-AuditResult -Results $results -Level "PASS" -Message "src/ contains only README.md"
    }
    elseif ($srcFiles.Count -eq 0) {
        Add-AuditResult -Results $results -Level "FAIL" -Message "src/ is missing README.md"
    }
    else {
        Add-AuditResult -Results $results -Level "FAIL" -Message "src/ should contain only README.md, found: $($srcFiles -join ', ')"
    }

    $scriptsReadme = Join-Path $ScriptsRoot "README.md"
    $scriptReadmeDocumentsShell = $false

    if (Test-Path -LiteralPath $scriptsReadme -PathType Leaf) {
        $scriptReadmeDocumentsShell = Select-String -Path $scriptsReadme -Pattern "clau-dex\.ps1" -Quiet
    }

    if ($scriptReadmeDocumentsShell) {
        Add-AuditResult -Results $results -Level "PASS" -Message "scripts/README.md documents scripts/clau-dex.ps1"
    }
    else {
        Add-AuditResult -Results $results -Level "FAIL" -Message "scripts/README.md does not document scripts/clau-dex.ps1"
    }

    Test-ForbiddenFilesAbsent -Results $results -RelativePaths @(
        "package.json",
        "package-lock.json",
        "npm-shrinkwrap.json",
        "pnpm-lock.yaml",
        "pnpm-workspace.yaml",
        "yarn.lock",
        "bun.lock",
        "bun.lockb",
        "Cargo.toml",
        "Cargo.lock",
        "pyproject.toml",
        "poetry.lock",
        "Pipfile",
        "Pipfile.lock",
        "requirements.txt",
        "composer.json",
        "composer.lock",
        "Gemfile",
        "Gemfile.lock",
        "go.mod",
        "go.sum"
    ) -Label "package manifests and lockfiles"

    Test-ForbiddenFilesAbsent -Results $results -RelativePaths @(
        ".github/workflows",
        ".gitlab-ci.yml",
        "azure-pipelines.yml",
        "Dockerfile",
        "docker-compose.yml",
        "docker-compose.yaml",
        "compose.yml",
        "compose.yaml",
        "deploy",
        "deployment"
    ) -Label "CI, container, and deployment artifacts"

    $failCount = @($results | Where-Object { $_.Level -eq "FAIL" }).Count
    $warnCount = @($results | Where-Object { $_.Level -eq "WARN" }).Count
    $passCount = @($results | Where-Object { $_.Level -eq "PASS" }).Count
    $overall = if ($failCount -gt 0) { "FAIL" } elseif ($warnCount -gt 0) { "WARN" } else { "PASS" }

    Write-Output "clau-dex bootstrap audit"
    Write-Output ""

    foreach ($result in $results) {
        Write-Output ("[{0}] {1}" -f $result.Level, $result.Message)
    }

    Write-Output ""
    Write-Output ("Summary: {0} ({1} pass, {2} warn, {3} fail)" -f $overall, $passCount, $warnCount, $failCount)
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
    "audit" { Show-Audit }
    "docs" { Show-Group -Title "Docs" -Path $DocsRoot }
    "prompts" { Show-Group -Title "Prompts" -Path $PromptsRoot }
    "agents" { Show-Group -Title "Agents" -Path $AgentsRoot }
    "rules" { Show-Rules }
    "scaffold-agent" { New-AgentScaffold -AgentName $Name }
}
