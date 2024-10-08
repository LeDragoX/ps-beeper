Import-Module "$PSScriptRoot\src\lib\Convert-ToFrequency.psm1" -Function Convert-ToFrequency -PassThru -Force
Import-Module "$PSScriptRoot\src\lib\Read-Glossary.psm1" -Function Read-Glossary -PassThru -Force
Import-Module "$PSScriptRoot\src\lib\Start-Beep.psm1" -Function Start-Beep -PassThru -Force

Function Main() {
    Clear-Host
    $GlossaryHash = Read-Glossary

    Start-Beep -Frequency 880 -d 175 # A5
    Start-Beep -Glossary $GlossaryHash -N "F#5" -D 500
    $OutputFile = "$(Split-Path "$PSCommandPath" -Leaf)-frequency.ps1"
    Convert-ToFrequency -Glossary $GlossaryHash -N "A5 F#5" -D "175" -O "$OutputFile" -PCBeeperMode
}

Main
