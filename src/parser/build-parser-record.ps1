function New-ParserRecord {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [string]$RelativePath,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$MetadataSections,
        [Parameter(Mandatory = $true)]
        [pscustomobject]$Classification
    )

    $summaryText = if ($MetadataSections.HasUsableSummaryText) {
        $MetadataSections.RawSummaryText
    }
    else {
        "Missing metadata: no summary text found under the supported headings. Review the file directly before using it."
    }

    return [pscustomobject][ordered]@{
        asset_kind = $AssetKind
        relative_path = $RelativePath
        matched_summary_heading = $MetadataSections.MatchedSummaryHeading
        matched_best_use_heading = $MetadataSections.MatchedBestUseHeading
        summary_text = $summaryText
        best_use_bullets = @($MetadataSections.BestUseBullets)
        heading_use = [pscustomobject][ordered]@{
            summary = $MetadataSections.SummaryHeadingUse
            best_use = $MetadataSections.BestUseHeadingUse
        }
        metadata_state = $Classification.MetadataState
        metadata_notices = @($Classification.MetadataNotices)
    }
}
