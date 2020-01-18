#Get public and private function definition files.
    $PublicFunction  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Exclude *tests* -ErrorAction SilentlyContinue )
    $PrivateFunction = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Exclude *tests* -ErrorAction SilentlyContinue )
    
#Dot source the files
    Foreach($import in @($PublicFunction + $PrivateFunction))
    {
        "importing $import"
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }   
Export-ModuleMember -Function $PublicFunction.Basename