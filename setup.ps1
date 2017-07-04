# Imports =========
Import-Module IISAdministration
#==================

# Variables =======
$websiteDir = "C:/Sites/DotNetNuke"
#==================

# Main ============
mkdir C:/Sites
Expand-Archive -LiteralPath "C:/DotNetNuke.zip" -DestinationPath $websiteDir
New-IISSite -Name "DotNetNuke" `
            -PhysicalPath $websiteDir `
            -BindingInformation "*:3000:"