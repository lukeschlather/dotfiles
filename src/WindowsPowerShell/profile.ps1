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
}

New-Alias which get-command
