Import-Module "$PSScriptRoot\Start-Beep.psm1" -Function Read-Glossary -PassThru -Force

function Translate-ToFrequency() {
    [CmdletBinding()]
    param(
        [Alias("G")]
        [hashtable] $Glossary,
        [Alias("N")]
        [String[]] $Notes, # C0, D4, E4, Db7...
        # In Milliseconds
        [Alias("D")]
        [Float] $Duration, # 100
        [Alias("O")]
        [String] $OutputFile = "$PSCommandPath-frequency.ps1",
        [Switch] $PCBeeperMode = $False
    )

    $Glossary = Read-Glossary -CSVFilePath "$PSScriptRoot\..\notes-glossary.csv"
    $Notes = $Notes.Clone().Split(" ")
    $CodeSnippet = ""
    If ($PCBeeperMode) { $CodePCBeeper = "" }

    ForEach ($Note in $Notes) {
        If ($Note -and $Duration) {
            $NoteName = $Note -replace '\d'
            $NoteOctave = $Note -replace '\D'
            $Frequency = $Glossary[$NoteName][$NoteOctave]
            Write-Host "Note: $NoteName$NoteOctave`: $Frequency Hz in $Duration`ms"
            $CodeSnippet += Write-Output "[System.Console]::Beep($Frequency, $Duration)`n"
            If ($PCBeeperMode) {
                $CodePCBeeper += Write-Output ".\pc-beeper.exe -f $Frequency -d $Duration`n"
            }
        }
    }

    $OutputFile = $OutputFile.Replace(".ps1", "")
    $CodeSnippet | Out-File -FilePath "$OutputFile.ps1";
    $CodePCBeeper | Out-File -FilePath "$OutputFile-pc-beeper.ps1";
    Write-Host "Done!" -ForegroundColor Cyan
}

Export-ModuleMember -Function *
