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

Describe "Get-PowerGitStatus Unit" -Tags Unit {

    context "Invalid Parameter" {

        It "should throw if path invalid" {

             { Get-PowerGitStatus 'MYNOTEXISTINGFOLDER' } | Should Throw
        }

    }

}

$currentDirectory = Get-Location

Describe "Get-PowerGitStatus Build" -Tags Build {

    BeforeAll {
        $testPath = "TestDrive:\README.md"
        Set-Content $testPath -value "My inital file to commit"
        Push-Location TestDrive:
        git init
        git add .
        git commit -am 'initial commit'
    }

    AfterAll {
        Push-Location $currentDirectory
    }

    It "Rule New-Component" {

        $Status = Get-PowerGitStatus
        $Status.Commit | Should Be 1
        $Status.Location | Should Be "TestDrive:"
    }

}
