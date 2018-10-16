# Dot source this script in any Pester test script that requires the module to be imported.

$ModuleManifestName = 'PowerGit.psd1'
$ModuleManifestPath = "$PSScriptRoot\..\$ModuleManifestName"

if (!$SuppressImportModule) {
    # -Scope Global is needed when running tests from inside of psake, otherwise
    # the module's functions cannot be found in the PowerGit\ namespace
    Import-Module $ModuleManifestPath -Scope Global
}
