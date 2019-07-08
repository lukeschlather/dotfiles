Get-WmiObject Win32_Product | Sort-Object Name | Select Name,version,Vendor | export-csv myprogramlist.csv

choco list --local-only

Install-PackageProvider -Name NuGet
Install-Module VSSetup
(Get-VSSetupInstance | Select-VSSetupInstance -Product *).packages
