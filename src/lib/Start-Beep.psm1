Import-Module "$PSScriptRoot\Read-Notes.psm1" -Function Read-Notes -PassThru -Force

function Start-Beep() {
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
        [String] $Note, # C0-C8
        [Alias("Dl")]
        [Int] $Delay = 0,
        [Switch] $Wait
    )

    $Note = $Note.Trim()

    # Multiple notes
    If ($Note -like '* *') {
        Write-Host "[$($MyInvocation.MyCommand.Name)] '$Note' contains whitespace!!! Isolating and running..." -ForegroundColor Yellow

        $Note -split '\s' | ForEach-Object {
            If ($_.Length -gt 3) {
                Write-Host "[$($MyInvocation.MyCommand.Name)] '$_' Unfiltered notes found!!! Isolating and running..." -ForegroundColor Yellow
                $Notes = Read-Notes -Notes $_
                Start-Beep -G $Glossary -N $Notes -D $Duration -Wait
            } Else {
                Start-Beep -G $Glossary -N $_ -D $Duration -Wait
            }
        }
        return
    }

    # Single Note without the Glossary
    If ($Frequency -and $Duration) {
        Write-Host "[$($MyInvocation.MyCommand.Name)] Note Frequency $Frequency`Hz: $Duration`ms"
        [System.Console]::Beep($Frequency, $Duration);
    }
    # Single Note with a Glossary
    If ($Note -and $Duration) {
        $NoteName = $Note -replace '\d'
        $NoteOctave = $Note -replace '\D'
        $Frequency = $Glossary[$NoteName][$NoteOctave]
        If ($Delay -eq 0) {
            Write-Host "[$($MyInvocation.MyCommand.Name)] Note <$NoteName$NoteOctave> $Frequency`Hz in $Duration`ms"
        }
        [System.Console]::Beep($Frequency, $Duration);

        If ($Delay -gt 0) {
            Write-Host "[$($MyInvocation.MyCommand.Name)] Note <$NoteName$NoteOctave> $Frequency`Hz in $Duration`ms + $Delay`ms"
            Start-Sleep -Milliseconds $Delay
        } ElseIf ($Wait) {
            Read-Host -Prompt "[$($MyInvocation.MyCommand.Name)] > Press ENTER to continue"
        }
    }
}

Export-ModuleMember -Function *
