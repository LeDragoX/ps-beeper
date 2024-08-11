Import-Module "$PSScriptRoot\..\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Convert-ToFrequency.psm1" -PassThru -Force

$Delay = 0
$GlossaryHash = Read-Glossary -CSVFilePath "$PSScriptRoot\..\notes-glossary.csv"
$OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
$TestTime = 140

# A song by Koji Kondo / Verified by Nova Nine (adapted)
$Notes = @"
E5 E5 E5 C5 E5 G5 G4 C5 G4 E4 A4 B4 A#4 A4 G4 E5 G5 A5 F5 G5 E5 C5 D5 B4 C5 G4 E4 A4 B4 A#4 A4 G4 E5 G5 A5 F5 G5 E5 C5 D5 B4 G5 F#5 F5 D#5 E5 G#4 A4 C5 A4 C5 D5 G5 F#5 F5 D#5 E5 C6 C6 C6 G3 G5 F#5 F5 D#5 E5 G#4 A4 C5 A4 C5 D5 D#5 D5 C5 G3 G3 C3 C3 G5 F#5 F5 D#5 E5 G#4 A4 C5 A4 C5 D5 C3 G5 F#5 F5 D#5 E5 C6 C6 C6 G3 C3 G5 F#5 F5 D#5 E5 G#4 A4 C5 A4 C5 D5 D#5 D5 C5 G3 G3 C3 C5 C5 C5 C5 D5 E5 C5 A4 G4 G2 C5 C5 C5 C5 D5 E5 C3 G2 C5 C5 C5 C5 D5 E5 C5 A4 G4 G2 E5 E5 E5 C5 E5 G5 G4 C5 G4 E4 A4 B4 A#4 A4 G4 E5 G5 A5 F5 G5 E5 C5 D5 B4 C5 G4 E4 A4 B4 A#4 A4 G4 E5 G5 A5 F5 G5 E5 C5 D5 B4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 A5 A5 A5 G5 F5 E5 C5 A4 G4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 F5 F5 F5 E5 D5 G4 E4 G3 E4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 A5 A5 A5 G5 F5 E5 C5 A4 G4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 F5 F5 F5 E5 D5 G4 E4 G3 E4 C4 C5 C5 C5 C5 D5 E5 C5 A4 G4 G2 C5 C5 C5 C5 D5 E5 E5 G5 E6 C6 D6 G6 C5 C5 C5 C5 D5 E5 C5 A4 G4 G2 E5 E5 E5 C5 E5 G5 G4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 A5 A5 A5 G5 F5 E5 C5 A4 G4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 F5 F5 F5 E5 D5 G4 E4 G3 E4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 A5 A5 A5 G5 F5 E5 C5 A4 G4 C4 E5 C5 G4 G3 C4 G#4 A4 F5 F5 A4 C4 B4 F5 F5 F5 E5 D5 G4 E4 G3 E4 C4 C5 G4 E4 A4 B4 A4 G#4 A#4 G#4 E4 D4 E4
"@

function Convert-Music() {
    Convert-ToFrequency -Glossary $GlossaryHash -N "$Notes" -D 180 -O "$OutputFile" -PCBeeperMode
}

function Play-Music() {
    Start-Beep -Glossary $GlossaryHash -N "$Notes" -D $TestTime -Wait
}

Clear-Host
Convert-Music
Play-Music
