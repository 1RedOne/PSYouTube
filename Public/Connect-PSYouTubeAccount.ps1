<#
.Synopsis
    Use this cmdlet to safely store credentials for your YouTube account for management via PowerShell
.DESCRIPTION
    With one cmdlet, you can connect to your YouTube account via the REST API.  After using this cmdlet, you can use any of the other *YouTube cmdlets to do all sorts of things
.EXAMPLE
    Connect-PSYouTubeAccount -ClientSecret [ClientSecret]


.EXAMPLE
    Connect-PSYouTubeAccount -Force

    If you need to renew your API key then rerun the cmdlet with -Force
#>
Function Connect-PSYouTubeAccount {
[CmdletBinding()]
param($clientSecret,[Switch]$force,[Switch]$new)
    $basePath = "$Env:AppData\WindowsPowerShell\Modules\PSYouTubeAccount\1.0"

 
if (-not (Test-Path $basePath) -or $force -or $new){
        if ($force){"`$force detected"}
        New-item -Force -Path $basePath -ItemType Directory
        
        $ThisTenantBase = "$basepath\$($values.Url)"
        Write-debug "Check the values back from the registration form"
        
        new-item -Force $ThisTenantBase -ItemType Directory 

        $clientSecretPath = "$ThisTenantBase\config_clientSecret.ps1xml"            

        $clientSecretPW = ConvertTo-SecureString $clientSecret -AsPlainText -Force
        $clientSecretPW | ConvertFrom-SecureString | Export-Clixml $clientSecretPath -Force
        
    } 
    else{
        $cred = Get-ChildItem -Path $basePath        
        Write-Verbose $cred.FullName
        try {
                $clientSecret = Import-Clixml -Path $cred.FullName -ErrorAction STOP | ConvertTo-SecureString                 
        }
        catch {
            Write-Warning "Corrupt Password file found, rerun with -Force to fix this"
            BREAK
        }        
        'Found cached Cred'            
        New-Variable -Scope Global -Name PSYouTubeclientSecret -Value $clientSecret -Force
    
    }

}