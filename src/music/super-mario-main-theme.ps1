Import-Module "$PSScriptRoot\..\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Convert-ToFrequency.psm1" -PassThru -Force

$Delay = 0
$GlossaryHash = Read-Glossary -CSVFilePath "$PSScriptRoot\..\notes-glossary.csv"
$OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
$TestTime = 150

function Convert-Music() {
    # A song by Koji Kondo / Verified by Nova Nine
    $Notes = @"
E5D3 E5D3 E5D3 C5D3 E5D3 G3G5 G4G2
G3C5 G4E3 E4C3 F3A4 G3B4 F#3A#4 F3A4
G4E3 C4E5 E4G5 A5F4 D4F5 E4G5 C4E5 C5A3 B3D5 G3B4
G3C5 G4E3 E4C3 F3A4 G3B4 F#3A#4 F3A4
G4E3 C4E5 E4G5 A5F4 D4F5 E4G5 C4E5 C5A3 B3D5 G3B4
C3 G5 G3F#5 F5D#5C4E5F3G#4A4 C4C5 C4A4 C5F3 D5
C3 G5 G3F#5 F5D#5G3 C4E5 G4C6 G4C6 G4C6 G3
C3 G5 G3F#5 F5D#5C4E5F3G#4A4 C4C5 C4A4 C5F3 D5
C3 G#3D#5 D5A#3 C4C5 G3G3 C3
C3 G5 G3F#5 F5D#5C4E5F3G#4A4 C4C5 C4A4 C5F3 D5
C3 G5 G3F#5 F5D#5G3 C4E5 G4C6 G4C6 G4C6 G3
C3 G5 G3F#5 F5D#5C4E5F3G#4A4 C4C5 C4A4 C5F3 D5
C3 G#3D#5 D5A#3 C4C5 G3G3 C3
C5G#2 C5 C5D#3 C5 D5G#3 G3E5 C5 A4C3 G4 G2
C5G#2 C5 C5D#3 C5 D5G#3 E5G3 C3 G2
C5G#2 C5 C5D#3 C5 D5G#3 G3E5 C5 A4C3 G4 G2
E5D3 E5D3 E5D3 C5D3 E5D3 G3G5 G4G2
G3C5 G4E3 E4C3 F3A4 G3B4 F#3A#4 F3A4
G4E3 C4E5 E4G5 A5F4 D4F5 E4G5 C4E5 C5A3 B3D5 G3B4
G3C5 G4E3 E4C3 F3A4 G3B4 F#3A#4 F3A4
G4E3 C4E5 E4G5 A5F4 D4F5 E4G5 C4E5 C5A3 B3D5 G3B4
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
B4D3 A5A5F3 G3A5 G5B3F5 F3E5 C5F3A4 C4G4 C4F3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
G3B4 G3F5 G3F5 G3F5 E5A3 B3D5 C4G4 E4G3E4 C4C3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
B4D3 A5A5F3 G3A5 G5B3F5 F3E5 C5F3A4 C4G4 C4F3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
G3B4 G3F5 G3F5 G3F5 E5A3 B3D5 C4G4 E4G3E4 C4C3
C5G#2 C5 C5D#3 C5 D5G#3 G3E5 C5 A4C3 G4 G2
C5G#2 C5 C5D#3 C5 D5G#3 E5G3 E5 G5C3 E6C6 D6G2 G6
C5G#2 C5 C5D#3 C5 D5G#3 G3E5 C5 A4C3 G4 G2
E5D3 E5D3 E5D3 C5D3 E5D3 G3G5 G4G2
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
B4D3 A5A5F3 G3A5 G5B3F5 F3E5 C5F3A4 C4G4 C4F3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
G3B4 G3F5 G3F5 G3F5 E5A3 B3D5 C4G4 E4G3E4 C4C3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
B4D3 A5A5F3 G3A5 G5B3F5 F3E5 C5F3A4 C4G4 C4F3
E5C3 C5 G4F#3 G3 C4G#4 F3A4 F5F3F5 C4A4 C4F3
G3B4 G3F5 G3F5 G3F5 E5A3 B3D5 C4G4 E4G3E4 C4C3
G3C5 G4E3 E4C3 F3A4 B4A4 G#4C#3 A#4G#4 E4C3 D4E4
"@

    Convert-ToFrequency -Glossary $GlossaryHash -N "$Notes" -D $TestTime -O "$OutputFile" -PCBeeperMode
}

function Play-Music() {
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5 E5 G#4 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5 E5 G#4 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3 G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5 E5 G#4 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 D#5 E5 G#4 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D#5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3 G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G2" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G2" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G2" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5 A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4 G3 E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5 A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4 G3 E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G2" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E6 C6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G6" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G2" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5 A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4 G3 E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5 A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G3" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5 F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "F5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4 G3 E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "C5" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "B4 A4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "A#4 G#4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "E4" -D $TestTime -Wait
    Start-Beep -Glossary $GlossaryHash -N "D4 E4" -D $TestTime -Wait
}

Clear-Host
Convert-Music
Play-Music
