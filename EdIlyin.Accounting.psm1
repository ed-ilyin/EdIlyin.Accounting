#                                                                     12345678
function Get-Accounting {
    ls | Get-AccountingData | echo
}
function Get-BankFolder {
    param (
        [Parameter(ValueFromPipeline)][string]$InvocationName
    )
    process {
        $InvocationName -replace '^(.+)\\.+?\.ps1$', '$1\BankExports' `
          | echo
    }
}
function Get-AccountingData {
    param (
        [Parameter(ValueFromPipeline)][System.IO.FileInfo]$FileInfo
    )
    process {
        $FileInfo `
          | Get-EhiContent `
          | ConvertFrom-EhiCsvOrXml `
          | Rename-EhiProperties `
          | echo
        }
}
function Get-EhiContent {
    param (
        [Parameter(ValueFromPipeline)][System.IO.FileInfo]$FileInfo
    )
    process {
        [pscustomobject]@{
            Content = $FileInfo | cat -e UTF8
            FileInfo = $FileInfo
        } | echo
    }
}
function ConvertFrom-EhiCsvOrXml {
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [System.Object[]]$Content,
        [Parameter(ValueFromPipelineByPropertyName)]
        [System.IO.FileInfo]$FileInfo
    )
    process {
        $Content `
          | ConvertFrom-Csv `
          | Add-Member -pa FileInfo $FileInfo `
          | echo
    }
}
function Rename-EhiProperties {
    param (
        [Parameter(ValueFromPipeline)]$Transaction
    )
    process {
        $Transaction | echo
    }
}
