Function Get-RepositoryStatistic {
    <#
    .SYNOPSIS
        Enumerates the child items of a location and invokes  git status on each item

    .EXAMPLE
        PS C:\>Get-RepositoryStatus -Path 'C:\dev\'
        Explanation of what the example does

    .DESCRIPTION
        Enumerates the child items of a location and invokes  git status on each item

    .PARAMETER Path
        Root path of repositories to check

    .PARAMETER Merges
        Should merges be counted?

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
        [string[]]
        $Path = ".",
        # Should merges be counted?
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = " Should merges be counted?"
        )]
        [switch] $Merges
    )

    begin {
        $startDir = Get-Location
    }

    process {
        foreach ($item in $Path) {
            Push-Location $Item

            if ($Merges) {
                $gitShortlog = git shortlog -sn --no-merges
            }
            else {
                $gitShortlog = git shortlog -sn
            }

            ConvertTo-PsCustomObject $gitShortlog  $item
        }
    }

    end {
        Push-Location $startDir
    }


}

function ConvertTo-PsCustomObject ($ShortLog, $item) {
    foreach ($authorLog in $ShortLog) {
        $statisticByAuthor = $authorLog -split "\t"
        [PSCustomObject]@{
            'Location' = $item
            'Author'   = $($statisticByAuthor[1])
            'Commits'  = $($statisticByAuthor[0])
        }
    }
}