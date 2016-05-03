function Get-BankFolder {
    param (
        [Parameter(ValueFromPipeline)][string]$InvocationName
    )
    $InvocationName -replace '^(.+)\\.+?\.ps1$', '$1\BankExports' `
      | Write-Output
}
function Get-AccountingData {
    param (
        [Parameter(ValueFromPipeline)][System.IO.FileInfo]$InputObject
    )
    process {
        switch ($InputObject.Extension) {
            .csv { $InputObject | cat | ConvertFrom-Csv }
        }
    }
}
function Get-Accounting {
    ls | Get-AccountingData
}
