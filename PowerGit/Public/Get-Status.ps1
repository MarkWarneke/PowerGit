
Function Get-RepositoryStatus {
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
            Test-Path $item -OutVariable $out

            Push-Location $Item

            $status = git status
            [PSCustomObject]@{
                'Location' = $item
                'Status'   = $status
            }
        }
    }

    end {
        Push-Location $startDir
    }
}