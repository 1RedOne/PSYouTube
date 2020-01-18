Function Get-DecryptedValue{
param($inputObj,$name)
    $WhatIfPreference = $false
    $Ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($inputObj)
    $result = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($Ptr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($Ptr)
    $result
    #New-Variable -Scope Global -Name $name -Value $result -PassThru -Force 
}