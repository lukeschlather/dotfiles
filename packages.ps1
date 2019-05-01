Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Import-Module PowerShellGet

Install-Module -Name PSReadLine
