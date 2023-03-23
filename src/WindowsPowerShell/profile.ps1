if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineKeyHandler -Key 'Ctrl+V' -Function Paste
    Set-PSReadLineKeyHandler -Key 'Ctrl+v' -Function Paste
    Set-PSReadLineKeyHandler -Key 'Ctrl+/' -Function Undo
    Set-PSReadLineKeyHandler -Key 'Ctrl+Backspace' -Function BackwardKillWord
    Set-PSReadLineKeyHandler -Key 'Ctrl+LeftArrow' -Function BackwardWord
    Set-PSReadLineKeyHandler -Key 'Ctrl+RightArrow' -Function ForwardWord
    Set-PSReadLineOption -AddToHistoryHandler $null
}

New-Alias which get-command

# function cd-Visual-Studio () {
#     cd (& "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -property InstallationPath)
# }


New-Alias ildasm "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\ildasm.exe"

function prompt() {
    (
        "_____________________________________________________________`n" +
        $env:username + '@' + $env:COMPUTERNAME + ' : ' +
        "$($executionContext.SessionState.Path.CurrentLocation)" + "`n" +
        " $(Get-Date -UFormat '+%Y-%m-%d %H:%M:%S')`n" +
        "$('> ' * ($nestedPromptLevel + 1))"
    );
}
