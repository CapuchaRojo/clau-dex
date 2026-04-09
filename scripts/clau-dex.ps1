[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateSet("help", "status", "audit", "docs", "prompts", "agents", "brief", "rules", "scaffold-agent", "new-agent", "scaffold-prompt")]
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
$CodexPromptsRoot = Join-Path $PromptsRoot "codex"
$ScriptsRoot = Join-Path $RepoRoot "scripts"
$SrcRoot = Join-Path $RepoRoot "src"
$VisibleCommands = @("help", "status", "audit", "docs", "prompts", "agents", "brief", "rules", "scaffold-agent", "scaffold-prompt")

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
        "  status          Show a concise operational summary and shell surface"
        "  audit           Check the narrow bootstrap repository invariants"
        "  docs            List checked-in docs"
        "  prompts         List prompt packs"
        "  agents          List agent definitions"
        "  brief           Generate a concise local briefing for prompt packs and super-agents"
        "  rules           Print the current operating rules summary"
        "  scaffold-agent  Scaffold a focused agent prompt in agents/super-agents/"
        "  scaffold-prompt Scaffold a prompt pack in prompts/codex/"
    )

    @(
        "clau-dex CLI shell"
        ""
        "Usage:"
        "  .\scripts\clau-dex.ps1 scaffold-agent <name>"
        "  .\scripts\clau-dex.ps1 scaffold-prompt <name>"
        "  .\scripts\clau-dex.ps1 [help|status|audit|docs|prompts|agents|brief|rules]"
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
    $auditResults = @(Get-AuditResults)
    $auditOutcome = Get-AuditOutcome -Results $auditResults
    $boundaryResult = @($auditResults | Where-Object { $_.Message -like "canonical shell boundary*" } | Select-Object -First 1)
    $hygieneResult = @($auditResults | Where-Object { $_.Message -like "local-state hygiene *" } | Select-Object -First 1)
    $boundarySummary = if ($boundaryResult.Count -eq 0) {
        "unknown"
    }
    elseif ($boundaryResult[0].Level -eq "PASS") {
        "intact"
    }
    else {
        "broken"
    }
    $hygieneSummary = if ($hygieneResult.Count -eq 0) {
        "unknown"
    }
    elseif ($hygieneResult[0].Level -eq "PASS") {
        "clean"
    }
    else {
        "warning-grade residue visible"
    }
    $warningPosture = if ($auditOutcome.WarnCount -gt 0) {
        "warning-first advisories currently visible"
    }
    else {
        "warning-first advisories currently quiet"
    }

    @(
        "clau-dex executable surface"
        ""
        "Repo root: $RepoRoot"
        "Shell path: .\scripts\clau-dex.ps1"
        "Shell role: local-first repository helper with narrow bootstrap auditing, briefing, and scaffolding commands"
        "Runtime status: no packaged app runtime, dependency manager, or external integration is present"
        ""
        "Operational summary:"
        "  Canonical shell boundary: $boundarySummary"
        "  Local-state hygiene: $hygieneSummary"
        "  Bootstrap posture: warning-first for advisory issues ($warningPosture)"
        "  src/ posture: no implementation runtime in src/"
        "  Detailed truth surface: run .\scripts\clau-dex.ps1 audit"
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
        "  scaffold-prompt creates a prompt-pack markdown file under prompts/codex/"
        "  new-agent remains available as a compatibility alias"
        "  audit checks a small hardcoded bootstrap-state surface"
        "  brief generates a structured local summary of checked-in prompt packs and super-agents"
        ""
        "Still out of scope:"
        "  No network behavior"
        "  No API integration"
        "  No formal test harness"
        "  One minimal GitHub Actions workflow validates help, status, audit, and brief"
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

function Get-MarkdownSectionContent {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Lines,
        [Parameter(Mandatory = $true)]
        [string]$Heading
    )

    $normalizedLines = @($Lines)

    $headingPattern = '^##\s+' + [Regex]::Escape($Heading) + '\s*$'
    $startIndex = -1

    for ($i = 0; $i -lt $normalizedLines.Count; $i++) {
        if ($normalizedLines[$i] -match $headingPattern) {
            $startIndex = $i + 1
            break
        }
    }

    if ($startIndex -lt 0) {
        return @()
    }

    $content = [System.Collections.Generic.List[string]]::new()

    for ($i = $startIndex; $i -lt $normalizedLines.Count; $i++) {
        if ($normalizedLines[$i] -match '^##\s+') {
            break
        }

        $content.Add([string]$normalizedLines[$i])
    }

    return @($content)
}

function Get-MarkdownSectionMatch {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Lines,
        [Parameter(Mandatory = $true)]
        [string[]]$Headings
    )

    foreach ($heading in @($Headings)) {
        $content = @(Get-MarkdownSectionContent -Lines $Lines -Heading $heading)
        $headingPattern = '^##\s+' + [Regex]::Escape($heading) + '\s*$'
        $hasHeading = @($Lines | Where-Object { $_ -match $headingPattern }).Count -gt 0

        if ($hasHeading) {
            return [pscustomobject]@{
                Heading = $heading
                Content = $content
            }
        }
    }

    return [pscustomobject]@{
        Heading = $null
        Content = @()
    }
}

function Get-FirstNonEmptyLine {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Lines
    )

    foreach ($line in @($Lines)) {
        $trimmed = $line.Trim()

        if (-not [string]::IsNullOrWhiteSpace($trimmed)) {
            return $trimmed
        }
    }

    return $null
}

function Get-BulletLines {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Lines,
        [int]$MaxCount = 2
    )

    $bullets = [System.Collections.Generic.List[string]]::new()

    foreach ($line in @($Lines)) {
        $trimmed = $line.Trim()

        if ($trimmed -match '^- ') {
            $bullets.Add($trimmed.Substring(2).Trim())
        }
    }

    if ($bullets.Count -eq 0) {
        return @()
    }

    return @($bullets | Select-Object -First $MaxCount)
}

function Get-BriefConvention {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("Prompt", "Agent")]
        [string]$Kind
    )

    if ($Kind -eq "Prompt") {
        return [pscustomobject]@{
            SummaryHeadings = @("Goal", "Purpose", "Overview")
            BestForHeadings = @("Use This Prompt When", "Use When", "Best Used For")
            PreferredSummaryHeading = "Goal"
            PreferredBestForHeading = "Use This Prompt When"
            KindLabel = "prompt pack"
        }
    }

    return [pscustomobject]@{
        SummaryHeadings = @("Purpose", "Goal", "Overview")
        BestForHeadings = @("Best Used For", "Use When", "Recommended For")
        PreferredSummaryHeading = "Purpose"
        PreferredBestForHeading = "Best Used For"
        KindLabel = "super-agent"
    }
}

function Get-MarkdownBriefRecord {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        [string]$Kind
    )

    $lines = @(Get-Content -LiteralPath $Path)
    $name = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $displayName = ($name -split '[-_]') | ForEach-Object {
        if ($_.Length -gt 0) {
            $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1)
        }
    }
    $displayName = $displayName -join ' '

    $convention = Get-BriefConvention -Kind $Kind
    $summaryMatch = Get-MarkdownSectionMatch -Lines $lines -Headings $convention.SummaryHeadings
    $bestForMatch = Get-MarkdownSectionMatch -Lines $lines -Headings $convention.BestForHeadings
    $summary = Get-FirstNonEmptyLine -Lines $summaryMatch.Content
    $when = Get-BulletLines -Lines $bestForMatch.Content -MaxCount 2
    $notices = [System.Collections.Generic.List[string]]::new()
    $missingConventionHeadings = [System.Collections.Generic.List[string]]::new()

    if ([string]::IsNullOrWhiteSpace($summaryMatch.Heading)) {
        $missingConventionHeadings.Add($convention.PreferredSummaryHeading)
    }
    elseif ($summaryMatch.Heading -ne $convention.PreferredSummaryHeading) {
        $notices.Add("Summary heading fallback used: expected '$($convention.PreferredSummaryHeading)', found '$($summaryMatch.Heading)'.")
    }

    if ([string]::IsNullOrWhiteSpace($bestForMatch.Heading)) {
        $missingConventionHeadings.Add($convention.PreferredBestForHeading)
    }
    elseif ($bestForMatch.Heading -ne $convention.PreferredBestForHeading) {
        $notices.Add("Best-for heading fallback used: expected '$($convention.PreferredBestForHeading)', found '$($bestForMatch.Heading)'.")
    }

    if ([string]::IsNullOrWhiteSpace($summary)) {
        $summary = "Missing metadata: no summary text found under the supported headings. Review the file directly before using it."
        $notices.Add("Summary metadata is missing or empty.")
    }

    if ($when.Count -eq 0) {
        $notices.Add("Best-for metadata is missing or has no bullet list.")
    }

    if ($missingConventionHeadings.Count -gt 0) {
        $notices.Add("Convention check: missing expected heading(s): $($missingConventionHeadings -join ', ').")
    }

    return [pscustomobject]@{
        Kind = $Kind
        Name = $name
        DisplayName = $displayName
        RelativePath = Resolve-Path -Relative $Path
        Summary = $summary
        BestFor = @($when)
        NextUse = if ($when.Count -gt 0) { $when[0] } else { $null }
        Notices = @($notices)
        MetadataState = [pscustomobject]@{
            KindLabel = $convention.KindLabel
            PreferredSummaryHeading = $convention.PreferredSummaryHeading
            PreferredBestForHeading = $convention.PreferredBestForHeading
            UsedSummaryHeading = $summaryMatch.Heading
            UsedBestForHeading = $bestForMatch.Heading
            HasSummaryText = -not [string]::IsNullOrWhiteSpace($summary) -and ($summary -notlike "Missing metadata:*")
            HasBestForBullets = $when.Count -gt 0
        }
    }
}

function Test-BriefMetadataRecord {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Record
    )

    $label = "$($Record.MetadataState.KindLabel) metadata check: $($Record.RelativePath)"
    $warnReasons = [System.Collections.Generic.List[string]]::new()

    if ([string]::IsNullOrWhiteSpace($Record.MetadataState.UsedSummaryHeading)) {
        $warnReasons.Add("missing supported summary heading (preferred: ## $($Record.MetadataState.PreferredSummaryHeading))")
    }
    elseif ($Record.MetadataState.UsedSummaryHeading -ne $Record.MetadataState.PreferredSummaryHeading) {
        $warnReasons.Add("used fallback summary heading ## $($Record.MetadataState.UsedSummaryHeading) instead of ## $($Record.MetadataState.PreferredSummaryHeading)")
    }

    if (-not $Record.MetadataState.HasSummaryText) {
        $warnReasons.Add("summary text missing or empty under the supported summary headings")
    }

    if ([string]::IsNullOrWhiteSpace($Record.MetadataState.UsedBestForHeading)) {
        $warnReasons.Add("missing supported best-for heading (preferred: ## $($Record.MetadataState.PreferredBestForHeading))")
    }
    elseif ($Record.MetadataState.UsedBestForHeading -ne $Record.MetadataState.PreferredBestForHeading) {
        $warnReasons.Add("used fallback best-for heading ## $($Record.MetadataState.UsedBestForHeading) instead of ## $($Record.MetadataState.PreferredBestForHeading)")
    }

    if (-not $Record.MetadataState.HasBestForBullets) {
        $warnReasons.Add("best-for bullets missing or empty under the supported best-for headings")
    }

    if ($warnReasons.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "$label passes"
        return
    }

    Add-AuditResult -Results $Results -Level "WARN" -Message "$label warns: $($warnReasons -join '; ')"
}

function Show-BriefSection {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$Records
    )

    Write-Output $Title

    if ($Records.Count -eq 0) {
        Write-Output "  (none)"
        Write-Output ""
        return
    }

    foreach ($record in $Records) {
        Write-Output "  - $($record.Name)"
        Write-Output "    Path: $($record.RelativePath)"
        Write-Output "    Summary: $($record.Summary)"

        if ($record.BestFor.Count -gt 0) {
            Write-Output "    Best for: $($record.BestFor -join '; ')"
        }
        else {
            Write-Output "    Best for: Missing metadata: no supported best-for bullets were found."
        }

        if (-not [string]::IsNullOrWhiteSpace($record.NextUse)) {
            Write-Output "    Next use: $($record.NextUse)"
        }
        else {
            Write-Output "    Next use: Review the file directly before choosing it."
        }

        if ($record.Notices.Count -gt 0) {
            Write-Output "    Notices: $($record.Notices -join ' ')"
        }

        Write-Output ""
    }
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

function Get-WarningGuidance {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$Results
    )

    $guidance = [System.Collections.Generic.List[string]]::new()

    foreach ($result in @($Results)) {
        $message = [string]$result.Message

        if ($result.Level -eq "WARN" -and $message -like "local-state hygiene warns:*") {
            $guidance.Add("Local-state hygiene: review the flagged file(s); remove leftovers you do not need, archive operator-local artifacts outside the repo when they matter, or ignore them intentionally if they are expected for local work.")
            continue
        }

        if ($result.Level -eq "WARN" -and $message -like "canonical shell boundary warns:*") {
            $guidance.Add("Canonical shell boundary: review helper script sprawl in scripts/; remove one-off helpers, archive them outside the canonical shell surface, or keep them intentionally only if the extra script is still justified during bootstrap.")
            continue
        }
    }

    return @($guidance | Select-Object -Unique)
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

function Get-ResidueRelativePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $repoUri = [System.Uri]::new(($RepoRoot.TrimEnd('\') + '\'))
    $pathUri = [System.Uri]::new($Path)
    $relative = $repoUri.MakeRelativeUri($pathUri).ToString()

    return [System.Uri]::UnescapeDataString($relative)
}

function Test-LocalStateHygiene {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results
    )

    $residueExactNames = @(
        ".DS_Store",
        "Thumbs.db"
    )
    $residueExtensions = @(
        ".bak",
        ".log",
        ".orig",
        ".rej",
        ".temp",
        ".tmp",
        ".zip"
    )
    $residueSuffixes = @("~")
    $matches = [System.Collections.Generic.List[string]]::new()

    $candidates = @(
        Get-ChildItem -LiteralPath $RepoRoot -Recurse -Force -File |
            Where-Object {
                $_.FullName -notlike "$($RepoRoot)\.git\*" -and
                $_.FullName -notlike "$($RepoRoot)\.codex\*"
            } |
            Sort-Object FullName
    )

    foreach ($candidate in $candidates) {
        $name = $candidate.Name
        $extension = $candidate.Extension.ToLowerInvariant()
        $relativePath = Get-ResidueRelativePath -Path $candidate.FullName

        if ($residueExactNames -contains $name) {
            $matches.Add($relativePath)
            continue
        }

        if ($residueExtensions -contains $extension) {
            $matches.Add($relativePath)
            continue
        }

        foreach ($suffix in $residueSuffixes) {
            if ($name.EndsWith($suffix)) {
                $matches.Add($relativePath)
                break
            }
        }
    }

    if ($matches.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "local-state hygiene check passes: no obvious residue patterns found"
        return
    }

    Add-AuditResult -Results $Results -Level "WARN" -Message "local-state hygiene warns: obvious local residue patterns found: $($matches -join ', ')"
}

function Test-CanonicalShellBoundary {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results
    )

    $entryPointExtensions = @(".bat", ".cmd", ".ps1", ".py", ".sh")
    $alternateEntryPoints = @(
        Get-ChildItem -LiteralPath $RepoRoot -Recurse -Force -File |
            Where-Object {
                $_.FullName -notlike "$($RepoRoot)\.git\*" -and
                $_.FullName -notlike "$($RepoRoot)\.codex\*" -and
                $_.Name -like "clau-dex.*" -and
                ($entryPointExtensions -contains $_.Extension.ToLowerInvariant()) -and
                $_.FullName -ne (Join-Path $ScriptsRoot "clau-dex.ps1")
            } |
            Sort-Object FullName |
            ForEach-Object { Get-ResidueRelativePath -Path $_.FullName }
    )

    if ($alternateEntryPoints.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "canonical shell boundary passes: scripts/clau-dex.ps1 is the only clau-dex entrypoint"
    }
    else {
        Add-AuditResult -Results $Results -Level "FAIL" -Message "canonical shell boundary broken: alternate clau-dex entrypoints found outside scripts/clau-dex.ps1: $($alternateEntryPoints -join ', ')"
    }

    $helperScriptExtensions = @(".bat", ".cmd", ".ps1", ".py", ".sh")
    $helperScripts = @()

    if (Test-Path -LiteralPath $ScriptsRoot -PathType Container) {
        $helperScripts = @(
            Get-ChildItem -LiteralPath $ScriptsRoot -File |
                Where-Object {
                    $_.Name -ne "clau-dex.ps1" -and
                    $_.Name -ne "README.md" -and
                    ($helperScriptExtensions -contains $_.Extension.ToLowerInvariant())
                } |
                Sort-Object FullName |
                ForEach-Object { Get-ResidueRelativePath -Path $_.FullName }
        )
    }

    if ($helperScripts.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "canonical shell boundary helper check passes: no extra helper scripts in scripts/"
        return
    }

    Add-AuditResult -Results $Results -Level "WARN" -Message "canonical shell boundary warns: helper scripts exist in scripts/ beyond the canonical shell surface: $($helperScripts -join ', ')"
}

function Test-BriefMetadataConvention {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [System.Collections.Generic.List[pscustomobject]]$Results,
        [Parameter(Mandatory = $true)]
        [ValidateSet("Prompt", "Agent")]
        [string]$Kind,
        [Parameter(Mandatory = $true)]
        [string]$RootPath
    )

    if (-not (Test-Path -LiteralPath $RootPath -PathType Container)) {
        return
    }

    $files = @()

    if ($Kind -eq "Prompt") {
        $files = @(
            Get-ChildItem -LiteralPath $RootPath -Recurse -File -Filter *.md |
                Where-Object { $_.Name -ne "README.md" } |
                Sort-Object FullName
        )
    }
    else {
        $files = @(
            Get-ChildItem -LiteralPath $RootPath -File -Filter *.md |
                Sort-Object FullName
        )
    }

    if ($files.Count -eq 0) {
        Add-AuditResult -Results $Results -Level "PASS" -Message "$Kind brief metadata check skipped: no files found"
        return
    }

    foreach ($file in $files) {
        $record = Get-MarkdownBriefRecord -Path $file.FullName -Kind $Kind
        Test-BriefMetadataRecord -Results $Results -Record $record
    }
}

function Show-Audit {
    $results = @(Get-AuditResults)
    $auditOutcome = Get-AuditOutcome -Results $results

    Write-Output "clau-dex bootstrap audit"
    Write-Output ""

    foreach ($result in $results) {
        Write-Output ("[{0}] {1}" -f $result.Level, $result.Message)
    }

    $warningGuidance = @(Get-WarningGuidance -Results $results)

    if ($warningGuidance.Count -gt 0) {
        Write-Output ""
        Write-Output "Next actions:"

        foreach ($entry in $warningGuidance) {
            Write-Output "  - $entry"
        }
    }

    Write-Output ""
    Write-Output ("Summary: {0} ({1} pass, {2} warn, {3} fail)" -f $auditOutcome.Overall, $auditOutcome.PassCount, $auditOutcome.WarnCount, $auditOutcome.FailCount)
}

function Get-AuditOutcome {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]]$Results
    )

    $failCount = @($Results | Where-Object { $_.Level -eq "FAIL" }).Count
    $warnCount = @($Results | Where-Object { $_.Level -eq "WARN" }).Count
    $passCount = @($Results | Where-Object { $_.Level -eq "PASS" }).Count
    $overall = if ($failCount -gt 0) { "FAIL" } elseif ($warnCount -gt 0) { "WARN" } else { "PASS" }

    return [pscustomobject]@{
        FailCount = $failCount
        WarnCount = $warnCount
        PassCount = $passCount
        Overall = $overall
    }
}

function Get-AuditResults {
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

    Test-LocalStateHygiene -Results $results
    Test-CanonicalShellBoundary -Results $results
    Test-BriefMetadataConvention -Results $results -Kind "Prompt" -RootPath $PromptsRoot
    Test-BriefMetadataConvention -Results $results -Kind "Agent" -RootPath $SuperAgentsRoot

    $workflowPath = Join-Path $RepoRoot ".github/workflows/bootstrap-shell-validation.yml"

    if (Test-Path -LiteralPath $workflowPath -PathType Leaf) {
        Add-AuditResult -Results $results -Level "PASS" -Message ".github/workflows/bootstrap-shell-validation.yml exists"
    }
    else {
        Add-AuditResult -Results $results -Level "FAIL" -Message ".github/workflows/bootstrap-shell-validation.yml is missing"
    }

    $extraWorkflowFiles = @()
    $workflowDirectory = Join-Path $RepoRoot ".github/workflows"

    if (Test-Path -LiteralPath $workflowDirectory -PathType Container) {
        $extraWorkflowFiles = @(
            Get-ChildItem -LiteralPath $workflowDirectory -File |
                Where-Object { $_.Name -ne "bootstrap-shell-validation.yml" } |
                ForEach-Object { ".github/workflows/$($_.Name)" }
        )
    }

    $extraInfraArtifacts = @(
        foreach ($relativePath in @(
            ".gitlab-ci.yml",
            "azure-pipelines.yml",
            "Dockerfile",
            "docker-compose.yml",
            "docker-compose.yaml",
            "compose.yml",
            "compose.yaml",
            "deploy",
            "deployment"
        )) {
            $fullPath = Join-Path $RepoRoot $relativePath

            if (Test-Path -LiteralPath $fullPath) {
                $relativePath
            }
        }
    )

    $extraArtifacts = @($extraWorkflowFiles + $extraInfraArtifacts)

    if ($extraArtifacts.Count -eq 0) {
        Add-AuditResult -Results $results -Level "PASS" -Message "extra CI, container, and deployment artifacts absent"
    }
    else {
        Add-AuditResult -Results $results -Level "FAIL" -Message "extra CI, container, and deployment artifacts present: $($extraArtifacts -join ', ')"
    }

    return @($results)
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

function Show-Brief {
    $docFiles = Get-RelativeFileList -Path $DocsRoot
    $promptFiles = @()
    $agentFiles = @()

    if (Test-Path -LiteralPath $PromptsRoot -PathType Container) {
        $promptFiles = @(
            Get-ChildItem -LiteralPath $PromptsRoot -Recurse -File -Filter *.md |
                Where-Object { $_.Name -ne "README.md" } |
                Sort-Object FullName
        )
    }

    if (Test-Path -LiteralPath $SuperAgentsRoot -PathType Container) {
        $agentFiles = @(
            Get-ChildItem -LiteralPath $SuperAgentsRoot -File -Filter *.md |
                Sort-Object FullName
        )
    }

    $promptBriefs = @(
        foreach ($file in $promptFiles) {
            Get-MarkdownBriefRecord -Path $file.FullName -Kind "Prompt"
        }
    )

    $agentBriefs = @(
        foreach ($file in $agentFiles) {
            Get-MarkdownBriefRecord -Path $file.FullName -Kind "Agent"
        }
    )

    @(
        "clau-dex local prompt and agent brief"
        ""
        "Repo status:"
        "  Bootstrap phase with local docs, prompt packs, super-agents, and one PowerShell shell entry point."
        "  Docs: $($docFiles.Count) file(s)"
        "  Prompt packs: $($promptFiles.Count) file(s)"
        "  Super-agents: $($agentFiles.Count) file(s)"
        "  Runtime: no packaged app runtime, dependency manager, or networked integration is present"
        ""
        "Purpose:"
        "  Provide a quick local briefing from checked-in prompt packs and super-agent files."
        "  This command reads local markdown headings only. It does not search remotely or generate AI summaries."
        ""
    ) | Write-Output

    Show-BriefSection -Title "Prompt Packs" -Records $promptBriefs
    Show-BriefSection -Title "Super-Agents" -Records $agentBriefs

    @(
        "Picker hint:"
        "  Start with a prompt pack when the task needs reusable task framing."
        "  Start with a super-agent when the task needs a reusable role with clear boundaries."
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

function New-PromptScaffold {
    param(
        [string]$PromptName
    )

    if ([string]::IsNullOrWhiteSpace($PromptName)) {
        throw "scaffold-prompt requires a name. Example: .\scripts\clau-dex.ps1 scaffold-prompt repo-check"
    }

    $slug = ConvertTo-Slug -Value $PromptName

    if ([string]::IsNullOrWhiteSpace($slug)) {
        throw "The supplied prompt name must contain letters or numbers."
    }

    $targetPath = Join-Path $CodexPromptsRoot "$slug.md"

    if (Test-Path -LiteralPath $targetPath) {
        throw "Prompt scaffold already exists: $targetPath"
    }

    if (-not (Test-Path -LiteralPath $CodexPromptsRoot)) {
        New-Item -ItemType Directory -Path $CodexPromptsRoot -Force | Out-Null
    }

    $title = ($slug -split "-") | ForEach-Object {
        if ($_.Length -gt 0) {
            $_.Substring(0, 1).ToUpperInvariant() + $_.Substring(1)
        }
    }

    $content = @(
        "# Codex Prompt Pack: $($title -join ' ')"
        ""
        "## Role"
        "You are Codex operating as a focused prompt-pack executor for `clau-dex`."
        ""
        "## Goal"
        "Define the specific reusable task this prompt pack should support in the current bootstrap-stage repository."
        ""
        "## Use This Prompt When"
        "- the task repeats often enough to deserve a reusable prompt"
        "- the task needs clear scope, boundaries, and output shape"
        "- the work should stay local-first, clean-room, and grounded in checked-in repo truth"
        ""
        "## Required Inputs"
        "- the user request"
        "- the repo files or docs that define the task boundaries"
        "- the current bootstrap constraints that limit the work"
        ""
        "## Operating Rules"
        "- start with repo inspection, not assumptions"
        "- keep the task narrow and reviewable"
        "- do not imply capabilities that are not checked in"
        "- prefer docs, prompts, and local scripts over speculative runtime additions"
        ""
        "## Expected Output"
        "Produce:"
        "1. the requested task result"
        "2. explicit limits or assumptions when they matter"
        "3. a concise verification note matched to the task"
        ""
        "## Completion Standard"
        "The work is complete when the output is reusable, bootstrap-safe, and ready for a small checkpoint."
    )

    Set-Content -LiteralPath $targetPath -Value $content

    @(
        "Created prompt scaffold:"
        "  $(Resolve-Path -Relative $targetPath)"
        ""
        "Next step:"
        "  Edit the Goal, Use This Prompt When, and Operating Rules sections for the specific prompt pack."
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
    "brief" { Show-Brief }
    "rules" { Show-Rules }
    "scaffold-agent" { New-AgentScaffold -AgentName $Name }
    "scaffold-prompt" { New-PromptScaffold -PromptName $Name }
}
