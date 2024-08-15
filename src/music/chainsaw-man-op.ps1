Import-Module "$PSScriptRoot\..\lib\Convert-ToFrequency.psm1" -Function Convert-ToFrequency -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force

$Delay = 0
$GlossaryHash = Read-Glossary
$OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
$TestTime = 120

# By Kenshi Yonezu / Adapted by Me
$NotesIntro1 = @"
A#4 A#4 A#4 C#5 A#4 C5 F4 A4 F4 G4 A4
A#4 A#4 A#4 C#5 A#4 C5 F4 A5 F#5 A5 F#5 A5 Bb5
A#4 A#4 A#4 C#5 A#4 C5 F4 C5 Eb5 C5 Eb5
A#4 A#4 A#4 C#5 A#4 C5 F4 A4 F4 G4 A4

A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4

F5 E5 F5 E5 A4 A#4 C5 C5 C#5 C#5 F#4 F4
F5 E5 F5 E5 A4 A#4 C5 C5 C5 C#5 C#5 C#5 Eb5 C5 C5
"@

$NotesIntro2 = @"
A#4 A4 A#4 D5 C#5 D5
E5 F5 E5 C#5 D5 E5
D5 Bb4 G4 F#4 G4 A4 G4
G4 F#4 G4 A4 Bb4
Bb4 A4 Bb4 C5 D5 Bb4 C5 G#4 G4

G#4 Bb4 B4 Bb4 G#4 F#4 G#4
G#4 Eb5 C#5 Bb4 B4 B4
B4 B4 F#5 E5 D#5 C#5 C5 C5
G#4 F#4 G#4 A4 B4 C#5 Eb5 C5 G#4 E5 Eb5
"@

$NotesChorus = @"
G#5 C#5 Eb5 E5 F#5 B4 E5 Eb5 C#5 C5 A4 A#4 G#4 G4 C#5
G#4 F#4 E4 F#4 E4 F#4 G#4 A4 B4 A4 G#4 F#4 C#5 C5 A4 G#4 E5 Eb5

G#5 C#5 Eb5 E5 F#5 B4 E5
Eb5 C#5 C5 A5 G#5 F#5 G#5 F#5 F5 Eb5 E5 E5
E5 Eb5 B4 C#5 Bb4 C#5 C#5
E5 Eb5 B4 C#5 Bb4 C#5 C#5
G#5 G5 G#5 G5 G#5 G5 G#5
G#5 F#5 E5 F#5 E5 Eb5 B4
"@

$NotesEnd = @"
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 A4 A4 A4
A4 Bb4 A4 Bb4 A4 A4 Bb4 Bb4 B4
"@

function Convert-Music() {
    Convert-ToFrequency -Glossary $GlossaryHash -N "$NotesIntro1 $NotesIntro2 $NotesChorus $NotesEnd" -D 130 -O "$OutputFile" -PCBeeperMode
}

function Play-Music() {
    Start-Beep -Glossary $GlossaryHash -N "$NotesIntro1 $NotesIntro2 $NotesChorus $NotesEnd" -D $TestTime -Wait
}

Clear-Host
Convert-Music
Play-Music
