function Get-NormalizedParserText {
    param(
        [AllowNull()]
        [string]$Value
    )

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ""
    }

    return ([Regex]::Replace($Value.Trim().ToLowerInvariant(), '\s+', ' '))
}

function Get-WeakParserBestUseBullets {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [string[]]$Bullets
    )

    $weakDefaults = switch ($AssetKind) {
        "prompt-pack" {
            @(
                "the task repeats often enough to deserve a reusable prompt",
                "the task needs clear scope, boundaries, and output shape",
                "the work should stay local-first, clean-room, and grounded in checked-in repo truth"
            )
        }
        "super-agent" {
            @(
                "one repeated repo task",
                "one narrow planning or review lane",
                "one clear output shape"
            )
        }
    }

    $weakMatches = [System.Collections.Generic.List[string]]::new()

    foreach ($bullet in $Bullets) {
        $normalizedBullet = Get-NormalizedParserText -Value $bullet

        if ($weakDefaults -contains $normalizedBullet) {
            $weakMatches.Add($bullet)
        }
    }

    return @($weakMatches)
}

function Get-ParserMetadataClassification {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$MetadataSections
    )

    $notices = [System.Collections.Generic.List[string]]::new()
    $missingConventionHeadings = [System.Collections.Generic.List[string]]::new()
    $weakBestUseBullets = @(Get-WeakParserBestUseBullets -AssetKind $AssetKind -Bullets $MetadataSections.BestUseBullets)
    $strongBestUseBullets = @(
        foreach ($bullet in $MetadataSections.BestUseBullets) {
            if (-not ($weakBestUseBullets -contains $bullet)) {
                $bullet
            }
        }
    )

    if ($MetadataSections.SummaryHeadingUse -eq "missing") {
        $missingConventionHeadings.Add($MetadataSections.Convention.PreferredSummaryHeading)
    }
    elseif ($MetadataSections.SummaryHeadingUse -eq "fallback") {
        $notices.Add("Summary heading fallback used: expected '$($MetadataSections.Convention.PreferredSummaryHeading)', found '$($MetadataSections.MatchedSummaryHeading)'.")
    }

    if ($MetadataSections.BestUseHeadingUse -eq "missing") {
        $missingConventionHeadings.Add($MetadataSections.Convention.PreferredBestUseHeading)
    }
    elseif ($MetadataSections.BestUseHeadingUse -eq "fallback") {
        $notices.Add("Best-for heading fallback used: expected '$($MetadataSections.Convention.PreferredBestUseHeading)', found '$($MetadataSections.MatchedBestUseHeading)'.")
    }

    if (-not $MetadataSections.HasUsableSummaryText) {
        $notices.Add("Summary metadata is missing or empty.")
    }

    if (-not $MetadataSections.HasUsableBestUseBullets) {
        $notices.Add("Best-for metadata is missing or has no bullet list.")
    }
    elseif ($strongBestUseBullets.Count -eq 0) {
        $notices.Add("Best-for metadata is present but still scaffold-grade. Replace the current bullets with file-specific picker guidance.")
    }

    if ($missingConventionHeadings.Count -gt 0) {
        $notices.Add("Convention check: missing expected heading(s): $($missingConventionHeadings -join ', ').")
    }

    $metadataState = if ($missingConventionHeadings.Count -gt 0) {
        "missing"
    }
    elseif ((($null -ne $MetadataSections.MatchedSummaryHeading) -and (-not $MetadataSections.HasUsableSummaryText)) -or (($null -ne $MetadataSections.MatchedBestUseHeading) -and (-not $MetadataSections.HasUsableBestUseBullets))) {
        "empty"
    }
    elseif ($strongBestUseBullets.Count -eq 0 -and $MetadataSections.HasUsableBestUseBullets) {
        "scaffold-grade"
    }
    elseif (($MetadataSections.SummaryHeadingUse -eq "fallback") -or ($MetadataSections.BestUseHeadingUse -eq "fallback")) {
        "fallback"
    }
    else {
        "clean"
    }

    return [pscustomobject]@{
        MetadataState = $metadataState
        MetadataNotices = @($notices)
    }
}
