function Get-ParserConvention {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind
    )

    switch ($AssetKind) {
        "prompt-pack" {
            return [pscustomobject]@{
                SummaryHeadings = @("Goal", "Purpose", "Overview")
                BestUseHeadings = @("Use This Prompt When", "Use When", "Best Used For")
                PreferredSummaryHeading = "Goal"
                PreferredBestUseHeading = "Use This Prompt When"
            }
        }
        "super-agent" {
            return [pscustomobject]@{
                SummaryHeadings = @("Purpose", "Goal", "Overview")
                BestUseHeadings = @("Best Used For", "Use When", "Recommended For")
                PreferredSummaryHeading = "Purpose"
                PreferredBestUseHeading = "Best Used For"
            }
        }
    }
}

function Get-ParserSectionContent {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Lines,
        [Parameter(Mandatory = $true)]
        [string]$Heading
    )

    $headingPattern = '^##\s+' + [Regex]::Escape($Heading) + '\s*$'
    $startIndex = -1

    for ($i = 0; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i] -match $headingPattern) {
            $startIndex = $i + 1
            break
        }
    }

    if ($startIndex -lt 0) {
        return @()
    }

    $content = [System.Collections.Generic.List[string]]::new()

    for ($i = $startIndex; $i -lt $Lines.Count; $i++) {
        if ($Lines[$i] -match '^##\s+') {
            break
        }

        $content.Add([string]$Lines[$i])
    }

    return @($content)
}

function Get-ParserSectionMatch {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Lines,
        [Parameter(Mandatory = $true)]
        [string[]]$Headings,
        [Parameter(Mandatory = $true)]
        [string]$PreferredHeading
    )

    foreach ($heading in $Headings) {
        $content = @(Get-ParserSectionContent -Lines $Lines -Heading $heading)

        if ($null -ne $content) {
            $headingPattern = '^##\s+' + [Regex]::Escape($heading) + '\s*$'
            $hasHeading = @($Lines | Where-Object { $_ -match $headingPattern }).Count -gt 0

            if ($hasHeading) {
                return [pscustomobject]@{
                    Heading = $heading
                    Content = @($content)
                    HeadingUse = if ($heading -eq $PreferredHeading) { "preferred" } else { "fallback" }
                }
            }
        }
    }

    return [pscustomobject]@{
        Heading = $null
        Content = @()
        HeadingUse = "missing"
    }
}

function Get-ParserFirstNonEmptyLine {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Lines
    )

    foreach ($line in $Lines) {
        $trimmed = $line.Trim()

        if (-not [string]::IsNullOrWhiteSpace($trimmed)) {
            return $trimmed
        }
    }

    return $null
}

function Get-ParserBulletLines {
    param(
        [Parameter(Mandatory = $true)]
        [object[]]$Lines,
        [int]$MaxCount = 2
    )

    $bullets = [System.Collections.Generic.List[string]]::new()

    foreach ($line in $Lines) {
        $trimmed = $line.Trim()

        if ($trimmed -match '^- ') {
            $bullets.Add($trimmed.Substring(2).Trim())
        }
    }

    return @($bullets | Select-Object -First $MaxCount)
}

function Get-ParserMetadataSections {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [string]$LiteralPath
    )

    $convention = Get-ParserConvention -AssetKind $AssetKind
    $lines = @(Get-Content -LiteralPath $LiteralPath)
    $summaryMatch = Get-ParserSectionMatch -Lines $lines -Headings $convention.SummaryHeadings -PreferredHeading $convention.PreferredSummaryHeading
    $bestUseMatch = Get-ParserSectionMatch -Lines $lines -Headings $convention.BestUseHeadings -PreferredHeading $convention.PreferredBestUseHeading
    $summaryText = Get-ParserFirstNonEmptyLine -Lines $summaryMatch.Content
    $bestUseBullets = @(Get-ParserBulletLines -Lines $bestUseMatch.Content -MaxCount 2)

    return [pscustomobject]@{
        Convention = $convention
        MatchedSummaryHeading = $summaryMatch.Heading
        MatchedBestUseHeading = $bestUseMatch.Heading
        SummaryHeadingUse = $summaryMatch.HeadingUse
        BestUseHeadingUse = $bestUseMatch.HeadingUse
        RawSummaryText = $summaryText
        HasUsableSummaryText = -not [string]::IsNullOrWhiteSpace($summaryText)
        BestUseBullets = @($bestUseBullets)
        HasUsableBestUseBullets = $bestUseBullets.Count -gt 0
    }
}
