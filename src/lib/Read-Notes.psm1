
function Read-Notes() {
    param (
        [Alias("N")]
        [String] $Notes
    )

    $Local:FilteredNotes = ""
    $Local:MultipleNotes = ""
    $NotesArray = $Notes -split "\s" | Where-Object { $_.Trim() -match "\S" }

    ForEach ($Note in $NotesArray) {
        If ($Note.Length -le 3) {
            $NoteName = $Note -replace '[0-9]'
            $NoteOctave = $Note -replace '[A-Z]' -replace '#'
            $FilteredNotes += "$NoteName$NoteOctave "
            Write-Host "[$($MyInvocation.MyCommand.Name)] [$($Note.Length)] Note: '$Note' | Detected as '$NoteName$NoteOctave'"

        } ElseIf ($Note.Length -gt 3) {
            $MultipleNotes = $Note -split '([^0-9]{1}#?[0-9])'
            $MultipleNotes = $MultipleNotes | Where-Object { $_.Trim() -match "\S" }
            $FilteredNotes += "$MultipleNotes "
            Write-Host "[$($MyInvocation.MyCommand.Name)] [$($Note.Length)C] Notes: '$Note'"
            Write-Host "[$($MyInvocation.MyCommand.Name)] [$($MultipleNotes.Length)N] Filter: '$MultipleNotes'"
        }
        $NoteName = $null
        $NoteOctave = $null
        $MultipleNotes = $null
    }

    $FilteredNotes = $FilteredNotes.Trim()
    Write-Host "[$($MyInvocation.MyCommand.Name)] [$($FilteredNotes.Length)] Result: '$FilteredNotes'" -ForegroundColor Green
    return $FilteredNotes
}

Export-ModuleMember -Function *
