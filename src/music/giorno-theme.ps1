Import-Module "$PSScriptRoot\..\lib\Convert-ToFrequency.psm1" -Function Convert-ToFrequency -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force

$Delay = 0
$GlossaryHash = Read-Glossary
$OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
$TestTime = 120

# A song by Yugo Kanno / Verified by Arda (Adapted 2 Octaves Higher)
$Notes = @"
B4 B4 B4 A4 B4 D5 B4 F#4
A4 B4 B4 B4 A4 B4 F5 E5
D5 A4 B4 B4 B4 A4 B4 D5
B4 F#4 A4 B4 B4 B4 A4 B4
F5 E5 D5 A4 B4 B4 B4 A4
B4 D5 B4 F#4 A4 B4 B4 B4
A4 B4 F5 E5 D5 A4 B4 B4
B4 A4 B4 D5 B4 F#4 A4 B4
B4 B4 A4 B4 B5 B5 B5 A5
B5 D6 B5 F#5 A5 B5 B5 B5
A5 B5 F6 E6 D6 A5 B5 B5
B5 A5 B5 D6 B5 F#5 A5 B5
B5 B5 A5 B5 F6 E6 D6 A5
B5 B5 B5 A5 B5 D6 B5 F#5
A5 B5 B5 B5 A5 B5 F6 E6
D6 A5 B5 B5 B5 A5 B5 D6
B5 F#5 A5 B5 B5 B5 A5 B5
B4 C#5 D5 E5 F#5 B4 D5 A5
G#5 F#5 E5 F#5 B4 C#5 D5 E5
F#5 B4 D5 A5 G#5 A5 B5 G#5
F#5 B4 C#5 D5 E5 F#5 B4 D5
A5 G#5 F#5 E5 F#5 B4 C#5 D5
E5 F#5 B4 D5 A5 B5 A5 G#5
F#5 D5 C#5 B4 A4 B4 B4 F#4
A4 B4 C#5 A4 B4 D5 C#5 B4
A4 B4 B4 F#4 C#5 D5 C#5 A4
E4 D6 C#6 B5 A5 B5 B5 F#5
A5 B5 C#6 A5 B5 D6 C#6 B5
A4 D5 F#5 E5 D#5 B4 A5 G#5
F#5 D5 C#5 B4 A4 B4 A4 B4
A4 B4 A4 B4 B4 C#5 D5 E5
F#5 D5 D5 E5 F5 E5 D5 C#5
D5 E5 F#5 F#5 B5 B4 C#5 D5
E5 D5 C#5 A5 G5 F#5 D5 D5
E5 F5 E5 D5 C#5 D5 E5 F#5
F#5 B5 B4 C#5 D5 G4 F#4 F4
D5 A#4 B4
"@

function Convert-Music() {
    Convert-ToFrequency -Glossary $GlossaryHash -N "$Notes" -D 160 -O "$OutputFile" -PCBeeperMode
}

function Play-Music() {
    Start-Beep -Glossary $GlossaryHash -N "$Notes" -D $TestTime -Wait
}

Clear-Host
Convert-Music
Play-Music
