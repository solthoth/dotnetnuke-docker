# Imports =========
Import-Module IISAdministration
#==================
# Global Flags ====
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
#==================
# Variables =======
$version = "9.1.0"
$buildCounter = "367"
$fullVersion = "$version.$buildcounter"
$packageUrl = "https://github.com/dnnsoftware/Dnn.Platform/releases/download/v${version}/DNN_Platform_${fullversion}_Install.zip"
$sitesDir = "C:/Sites"
$websiteDir = "$sitesDir/DotNetNuke"
$zipFile = "C:/DotNetNuke.zip"
#==================
# Main ============
New-Item -ItemType directory -Path $sitesDir -Force

Invoke-WebRequest $packageUrl -OutFile $zipFile -UseBasicParsing

Expand-Archive -LiteralPath $zipFile -DestinationPath $websiteDir
New-IISSite -Name "DotNetNuke" `
            -PhysicalPath $websiteDir `
            -BindingInformation "*:3000:"