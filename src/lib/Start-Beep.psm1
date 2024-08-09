Function Start-Beep() {
    [CmdletBinding()]
    param (
        # In Hz
        [Alias("F")]
        [Parameter(Position = 0)]
        [Float] $Frequency, # 523.25
        # In Milliseconds
        [Alias("D")]
        [Parameter(Position = 1)]
        [Float] $Duration, # 100
        [Alias("G")]
        [hashtable] $Glossary,
        [Alias("N")]
        [String] $Note # C0-C8
    )

    If ($Frequency -and $Duration) {
        Write-Host "Note: $Frequency Hz: $Duration`ms"
        [System.Console]::Beep($Frequency, $Duration);
    }
    If ($Note -and $Duration) {
        $NoteName = $Note -replace '\d'
        $NoteOctave = $Note -replace '\D'
        $Frequency = $Glossary[$NoteName][$NoteOctave]
        Write-Host "Note: $NoteName$NoteOctave`: $Frequency Hz in $Duration`ms"
        [System.Console]::Beep($Frequency, $Duration);
    }
}

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
            Write-Host "==> Note $($Note.Note)$($Note.Length): $($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)"
            $Glossary[$Note.Note] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
        } Else {
            Write-Host "==> Note $($Note.Note): $($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)"
            $Glossary[$Note.Note.Split("/")[0]] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
            $Glossary[$Note.Note.Split("/")[1]] = @($Note.0, $Note.1, $Note.2, $Note.3, $Note.4, $Note.5, $Note.6, $Note.7, $Note.8)
        }
    }

    Write-Host $Glossary.Keys
    return $Glossary
}

Export-ModuleMember -Function *
