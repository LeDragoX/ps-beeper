Import-Module "$PSScriptRoot\src\lib\Start-Beep.psm1"

Function Main() {
    Clear-Host
    $GlossaryHash = Read-Glossary
    $GlossaryHash.Keys | ForEach-Object { Write-Host "$($_), $($GlossaryHash.$_)" }

    Start-Beep -Frequency 999.00 -d 100
    Start-Beep -Glossary $GlossaryHash -N "Db6" -D 200
}

Main
