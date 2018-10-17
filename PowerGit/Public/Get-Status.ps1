
Function Get-Status {
    <#
        .SYNOPSIS
            Enumerates the child items of a location and invokes  git status on each item

        .EXAMPLE
            PS C:\>Get-Status -Path 'C:\dev\'
            Explanation of what the example does

        .DESCRIPTION
            Enumerates the child items of a location and invokes  git status on each item

        .PARAMETER Path
            Root path of repositories to check


        .NOTES
            Will push the location for eacht path provided
    #>

    [OutputType("PSCustomObject")]
    param (
        # Root path of repositories to check
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = "Root path of repositories to check"
        )]
        [string[]] $Path = "."
    )

    begin {
        $startDir = Get-Location
    }

    process {

        foreach ($item in $Path) {
            Test-Path $item | Out-Null
            Push-Location $Item
            $status = git status
            ConvertTo-PsCustomObjectStatus $status $(Get-Location)
        }
    }

    end {
        Push-Location $startDir
    }
}

function ConvertTo-PsCustomObjectStatus ($Git, $item) {

    $branch = $git[0] -split "\s"
    $remoteBanch = $git[1] -split "\s"

    $i = 7
    $modified = @()
    while (! (IsEmpty($git[$i]) )) {
        $modified += ($git[$i] -split "\s")[-1]
        $i++
    }

    while (! (IsUntrackedFiles($git[$i]))) {
        $i++
    }
    $i += 3

    $untracked = @()
    while (! (IsEmpty($git[$i]))) {
        $untracked += ($git[$i] -split "\t")[-1]
        $i++
    }

    $Status = [Status]::new()
    $Status.Location = $item
    $Status.Branch = $branch[2]
    $Status.RemoteBranch = $remoteBanch[-1].replace("'", '').replace('.', '')
    $status.Modified = $modified
    $Status.Untracked = $untracked
    $Status.Status = $($Git)

    Write-Output $Status
}

function IsModified($line) {
    $split = ($line -split "\s")
    return $split[1] -eq "modified:"
}

function IsUntrackedFiles($line) {
    return $line -eq "Untracked files:"
}

function IsEmpty($line) {
    return [string]::IsNullOrEmpty($line)
}

class Status {
    [System.Management.Automation.PathInfo] $Location
    [String] $Branch
    [String] $RemoteBranch
    [System.IO.FileInfo[]] $Modified
    [System.IO.FileInfo[]] $Untracked
    hidden [String] $Status
}

Get-Status