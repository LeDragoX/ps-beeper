function Read-Glossary() {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param (
        $CSVFilePath = "$PSScriptRoot\..\notes-glossary.csv"
    )
    $Glossary = [hashtable] [ordered]@{}

    $CSVFile = Import-Csv -Path "$CSVFilePath" -Delimiter ";"

    ForEach ($Note in $CSVFile) {
        If ($Note.Note -notlike "*/*") {
            Write-Host "[$($MyInvocation.MyCommand.Name)] Note $($Note.Note)$($Note.Length): $($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)"
            $Glossary[$Note.Note] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
        } Else {
            Write-Host "[$($MyInvocation.MyCommand.Name)] Note $($Note.Note): $($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)"
            $Glossary[$Note.Note.Split("/")[0]] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
            $Glossary[$Note.Note.Split("/")[1]] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
        }
    }

    Write-Host "[$($MyInvocation.MyCommand.Name)] $($Glossary.Keys)"
    return $Glossary
}

Export-ModuleMember -Function *
