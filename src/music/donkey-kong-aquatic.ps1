Import-Module "$PSScriptRoot\..\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force
Import-Module "$PSScriptRoot\..\lib\Convert-ToFrequency.psm1" -PassThru -Force

$Delay = 0
$GlossaryHash = Read-Glossary -CSVFilePath "$PSScriptRoot\..\notes-glossary.csv"
$OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
$TestTime = 150

function Convert-DKAquatic() {
    $Notes = @"
 B4  A2  C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4 B4 C5 G4 E4  A4 F2 G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3  C5 B5E5  B4 A2 C5G4E4B4C5G4E4B4C5G4E4B4C5G4E4B4C5G4E4B4C5G4E4B4C5G4E4B4C5G4E4  A4 F2 G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3A4G4C4D4F4E4C4A3  F4 D2 E4A3C4F4E4G4D4F4E4A3C4F4E4G4D4F4E4A3C4F4E4G4D4F4E4A3C4F4E4G4D4  C5 B2 B4E4G4A4G4B3D4C5B4E4G4A4G4B3D4C5B4E4G4A4G4B3D4C5B4E4G4A4G4B3D4  E4 C4A4A3B4 A2A2A2A2A2 A3A3A2A2A2A2A2 A3A3A2A2A2A2A2 A3A3A2A2A2A2A2 A3  C5 F3A4G4F4E5 C3C3F2C2F2 F3F3C3C3F2C2F2 F3F3C3C3F2C2F2 F3F3C3C3F2C2F2 F3  E4 C4A4A3B4 A2A2A2A2A2B4 C5 A3  G5 A3  B4 A2  C5 A2  G5 A2  B4 A2  C5 A2 G5 A3 B4  C5 A3 A2A2A2A2A2B4 C5 A3  G5 A3  B4 A2  C5 A2  G5 A2  B4 A2  C5 A2 G5 A3 B4  F3 B4  C5 C3  G4 C3  B4 F2  C5 C2  G4 F2 B4 C5 F3  F3 G4  B4 C3  C5 C3  G4 F2  B4 C2  C5 F2  F3  F3 B4 C3C3F2C2F2 F3 F3 A4 C3C3F2C2F2 F3  F6 D3  E6 D2  G6 D2  D6 D2  F6 D2  E6 D2 A5 C6 D3  F6 D3  E6 D2  G6 D2  D6 D2  F6 D2  E6 D2 A5 C6 D3  F6 D3  E6 D2  G6 D2  D6 D2  F6 D2  E6 D2 A5 C6 D3  F6 D3  E6 D2  G6 D2  D6 D2  F6 D2  E6 D2 A5 C6 D3  D4 B3A4G4B4 B2B2B2B2B2 B3B3B2B2B2B2B2 B3 B3B2B2B2 G3 B2 A3 B3 B2 C4D4E4 B3 G4 A4 B3 G4 A4 B4 B2 C5 D5 B2 E5 G5 B2 A5 G5 B2 A5 B5 B2 C6D6E6 G6 B3 A6 A3A2A2A2 B4 A2 A2A4 E4 A3 A3A2A2A2A2A2 A3 A3A2 B4 A2  A4 A2  B4 A2 A2C5 A3 D5 A3A2 C5 A2  B4 A2 A2A2G4A3 F3C3C3F2 G4 C2 F2A4 C4 F3 F3C3C3F2C2F2 F3 F3C3C3F2 G4 C2 F2A4 C4 F3 F3C3C3F2C2F2 F3 A3A2A2A2 B4 A2 A2A4 E4 A3 A3A2A2A2A2A2 A3 A3A2 B4 A2  A4 A2  B4 A2 A2C5 A3 D5 A3A2 E5 A2  G5 A2 A2A2A5A3  C5 F3 C3C3F2 G4 C2 F2A4 C4 F3 F3C3C3F2 G5 C2 F2A5 C5 F3 F3C3C3F2 G4 C2 F2A4 C4 F3 F3C3C3F2C2F2 F3 D3D2 F5 D2  E5 D2  F5 D2 D2E5 F5 D3 D3D2 E5 D2  A4 D2 D2D2 D3 D3D2 F5 D2  E5 D2  F5 D2 D2E5 G5 D3 D3D2 F5 D2  E5 D2 D2D2D5D3  G6 B3  G5 B2  G5 B2  G6 B2  G6 B2  G5 B2 G5 G6 B3  G6 B3  G5 B2  G5 B2  G6 B2 B2B2 B3  G6 B3  G5 B2  G5 B2  G6 B2  G6 B2  G5 B2 G5 G6 B3  G6 B3  G5 B2  G5 B2  G6 B2 B2B2 B3
"@

    Convert-ToFrequency -Glossary $GlossaryHash -N "$Notes" -D $TestTime -O "$OutputFile" -PCBeeperMode
}


function Play-DKAquatic() {
}

Clear-Host
Convert-DKAquatic
Play-DKAquatic
