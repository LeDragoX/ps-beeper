Import-Module "$PSScriptRoot\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\Read-Notes.psm1" -Function Read-Notes -PassThru -Force

function Convert-ToFrequency() {
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
        [String] $OutputFile = "-frequency.ps1",
        [Switch] $PCBeeperMode = $False
    )

    $CodeSnippet = ""
    $Glossary = Read-Glossary -CSVFilePath "$PSScriptRoot\..\notes-glossary.csv"
    $Notes = Read-Notes -N "$Notes"
    $Notes = $Notes.Split(" ")
    $OutputFile = $OutputFile.Replace(".ps1", "")
    $OutputPath = "$PSScriptRoot\..\music\exported\$OutputFile"
    If ($PCBeeperMode) { $CodePCBeeper = "" }

    ForEach ($Note in $Notes) {
        If ($Note -and $Duration) {
            $NoteName = $Note -replace '\d'
            $NoteOctave = $Note -replace '\D'
            $Frequency = $Glossary[$NoteName][$NoteOctave]
            $CodeSnippet += Write-Output "[System.Console]::Beep($Frequency, $Duration)`n"
            If ($PCBeeperMode) {
                $CodePCBeeper += Write-Output ".\pc-beeper.exe -f $Frequency -d $Duration`n"
            }
        }
        Write-Host "[$($MyInvocation.MyCommand.Name)] Note <$NoteName$NoteOctave> $Frequency`Hz in $Duration`ms"
    }

    $CodeSnippet | Out-File -FilePath "$OutputPath.ps1";
    $CodePCBeeper | Out-File -FilePath "$OutputPath-pc-beeper.ps1";
    Write-Host "[$($MyInvocation.MyCommand.Name)] Done!" -ForegroundColor Cyan
}

Export-ModuleMember -Function *
