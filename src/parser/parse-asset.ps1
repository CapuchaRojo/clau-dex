. (Join-Path $PSScriptRoot "read-metadata-sections.ps1")
. (Join-Path $PSScriptRoot "classify-metadata-state.ps1")
. (Join-Path $PSScriptRoot "build-parser-record.ps1")

function ConvertTo-ParserRelativePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RepoRoot,
        [Parameter(Mandatory = $true)]
        [string]$LiteralPath
    )

    $resolvedPath = (Resolve-Path -LiteralPath $LiteralPath).Path
    $repoUri = [System.Uri]::new(($RepoRoot.TrimEnd('\') + '\'))
    $fileUri = [System.Uri]::new($resolvedPath)
    $relativePath = $repoUri.MakeRelativeUri($fileUri).ToString()

    return [System.Uri]::UnescapeDataString($relativePath).Replace('\', '/')
}

function Test-ParserAssetScope {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    switch ($AssetKind) {
        "prompt-pack" { return $RelativePath.StartsWith("prompts/") }
        "super-agent" { return $RelativePath.StartsWith("agents/super-agents/") }
    }
}

function Invoke-ParseAsset {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("prompt-pack", "super-agent")]
        [string]$AssetKind,
        [Parameter(Mandatory = $true)]
        [string]$RelativePath
    )

    $repoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
    $literalPath = Join-Path $repoRoot $RelativePath

    if (-not (Test-Path -LiteralPath $literalPath -PathType Leaf)) {
        throw "Parser asset not found: $RelativePath"
    }

    if ([System.IO.Path]::GetExtension($literalPath) -ne ".md") {
        throw "Parser asset must be a markdown file: $RelativePath"
    }

    $normalizedRelativePath = ConvertTo-ParserRelativePath -RepoRoot $repoRoot -LiteralPath $literalPath

    if (-not (Test-ParserAssetScope -AssetKind $AssetKind -RelativePath $normalizedRelativePath)) {
        throw "Parser asset kind '$AssetKind' is out of scope for path '$normalizedRelativePath'."
    }

    $metadataSections = Get-ParserMetadataSections -AssetKind $AssetKind -LiteralPath $literalPath
    $classification = Get-ParserMetadataClassification -AssetKind $AssetKind -MetadataSections $metadataSections

    return New-ParserRecord -AssetKind $AssetKind -RelativePath $normalizedRelativePath -MetadataSections $metadataSections -Classification $classification
}
