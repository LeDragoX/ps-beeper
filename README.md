# PS Beeper

A powershell script to reproduce music through PowerShell (or your motherboard speaker) if you have it installed and also [PC Beeper](https://github.com/cocafe/pc-beeper)! Via a PowerShell generated code.

## Usage

Example code working, display sound via PowerShell.

```ps1
.\Ps-Beeper.ps1
```

## Other Sounds

Play other sounds inside the `src\music` folder.

```ps1
.\src\music\megalovania.ps1
```

## Generated files

If you want to input more sounds you can use `.\src\music\megalovania.ps1` as an example, you just need the notes from the music.
**The script to run with pc-beeper requires it to be on the same folder as the executable file.**

> [!CAUTION]
> Also, be careful to not run without ADMIN privileges, as it is required by them, or else you will get a wonderful amount of UAC prompts.

## Known Limitations

The script doesn't recognize minor chords or chords, you can put only a single note per time, or else it will do nothing.
The files generated will use a **fix duration** to play the frequencies, adjusting requires manual tweaking, that's why it's sound too fast or too slow sometimes.

# License

This project is under the [MIT](LICENSE) License.
