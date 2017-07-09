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
Install-Module xWebAdministraion -Force
Install-Module cNtfsAccessControl -Force

Configuration DNNSetup
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration, xWebAdministration, cNtfsAccessControl
    node localhost
    {
        File SitesDirectory
        {
            Ensure = "Present"
            Type = "Directory"
            DestinationPath = $sitesDir
        }
        File DotNetNuke_WebsiteDir
        {
            Ensure = "Present"
            Type = "Directory"
            DestinationPath = $websiteDir
            DependsOn = @("[File]SitesDirectory")
        }
        xWebAppPool DotNetNuke_AppPool
        {
            Name = "DotNetNuke"
            Ensure = "Present"
            State = "Started"
            autoStart = $true
            startMode = "AlwaysRunning"
            identityType = "ApplicationPoolIdentity"
        }
        cNtfsPermissionEntry DotNetNuke_DirPermission
        {
            Ensure = "Present"
            Path = $websiteDir
            Principal = "IIS APPPOOL\DotNetNuke"
            AccessControlInformation = cNtfsAccessControlInformation
            {
                AccessControlType = "Allow"
                FileSystemRights = "Modify,ReadAndExecute,ListDirectory,Read,Write"
            }
            DependsOn = @("[File]DotNetNuke_WebsiteDir","[xWebAppPool]DotNetNuke_AppPool")
        }
        xWebsite DotNetNuke_Site
        {
            Name = "DotNetNuke"
            Ensure = "Present"
            PhysicalPath = $websiteDir
            State = "Started"
            BindingInfo = MSFT_xWebBindingInformation 
            {
                Protocol = "http"
                IPAddress = "*"
                Port = "80"
                Hostname = "dnndev.me"
            }
            ApplicationPool = "DotNetNuke"
            PreloadEnabled = $true
            ServiceAutoStartEnabled = $true
            AuthenticationInfo = MSFT_xWebAuthenticationInformation 
            {
                Anonymous = $true
            }
            DependsOn = @("[File]DotNetNuke_WebsiteDir", "[xWebAppPool]DotNetNuke_AppPool")
        }
    }
}

DNNSetup

Start-DscConfiguration -Path .\DNNSetup -Wait -verbose -Force