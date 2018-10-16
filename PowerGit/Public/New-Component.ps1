#REQUIRES -Version 5.0
#REQUIRES #-Modules
#REQUIRES #-RunAsAdministrator

function New-Component {
    <#
        .SYNOPSIS
        Short description

        .DESCRIPTION
        Long description

        .PARAMETER ComputerName
        Parameter description

        .PARAMETER Confirm
        Prompts the user to confirm for state changing functions

        .PARAMETER WhatIf
        Dry run, will not execute state changing functions

        .EXAMPLE
        PS:\>New-Component -ComputerName $ComputerName
        PS:\>#return
        An example

        .NOTES
        General notes
    #>

    [CmdletBinding(
        SupportsShouldProcess = $True,
        PositionalBinding = $True,
        DefaultParameterSetName = "Default"
    )]

    [OutputType([PSCustomObject])]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ParameterSetName = 'Default',
            HelpMessage = "ComputerName to invoke request"
        )]
        [Alias("HostName")]
        [string] $ComputerName
    )

    begin {
        Write-Verbose "[$(Get-Date)] Begin"
    }

    process {
        Write-Verbose "[$(Get-Date)] Process"

        try {
            Write-Verbose "[$(Get-Date)] Try"

            if ($PSCmdlet.ShouldProcess( (" {0}"  <#-f $SHOULD_PROCESS_MESSAGE #>) )) {
                Write-Verbose "[$(Get-Date)] ShouldProcess"
                # Careful action

            }
            else {


            }

            # return value
            [PSCustomObject]@{
                'ComponentName' = $ComponentName
            }
        }
        catch [Exception] {
            $_.Exception | Format-List * -Force | Write-Verbose
            Write-Verbose "$($_.ScriptStackTrace)"
            # throw $_
            Write-Error -ErrorId $_
        }
    }

    end {
    }
}

# Export-ModuleMember -Function New-Component
# New-Component

