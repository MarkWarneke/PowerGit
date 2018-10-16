$script:ModuleName = 'PowerGit'
# Removes all versions of the module from the session before importing
Get-Module $ModuleName | Remove-Module
$ModuleBase = Split-Path -Parent $MyInvocation.MyCommand.Path
# For tests in .\Tests subdirectory
if ((Split-Path $ModuleBase -Leaf) -eq 'Test') {
    $ModuleBase = Split-Path $ModuleBase -Parent
}
## this variable is for the VSTS tasks and is to be used for refernecing any mock artifacts
$Env:ModuleBase = $ModuleBase
Import-Module $ModuleBase\$ModuleName.psd1 -PassThru -ErrorAction Stop | Out-Null

Describe "New-Component Unit" -Tags Unit {

    context "Invalid Parameter" {

        It "should " {

            # New-Component | Should Be $true
        }

    }

}

Describe "New-Component Build" -Tags Unit {

    BeforeAll {

    }

    AfterAll {

    }

    It "Rule New-Component" {

        # New-Component | Should Be $true
    }

}
