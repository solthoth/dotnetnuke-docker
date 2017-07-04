# Imports =========
Import-Module IISAdministration
#==================
# Global Flags ====
$ErrorActionPreference = 'Stop'
#==================
# Variables =======
$sitesDir = "C:/Sites"
$websiteDir = "$sitesDir/DotNetNuke"
$zipFile = "C:/DotNetNuke.zip"
#==================
# Main ============
New-Item -ItemType directory -Path $sitesDir -Force | Out-Null

Expand-Archive -LiteralPath $zipFile -DestinationPath $websiteDir
New-IISSite -Name "DotNetNuke" `
            -PhysicalPath $websiteDir `
            -BindingInformation "*:3000:"