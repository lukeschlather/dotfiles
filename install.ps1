# WIP

New-Item -Path "$home\Documents\WindowsPowerShell" -ItemType SymbolicLink -Value "$home\dotfiles\primary\WindowsPowerShell" -Force

New-Item -Path "$env:appdata\.emacs" -ItemType SymbolicLink -Value "$home\dotfiles\primary\.emacs" -Force
New-Item -Path "$env:appdata\.autoinsert" -ItemType SymbolicLink -Value "$home\dotfiles\primary\.autoinsert" -Force

New-Item -Path "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\ljfs.ahk" `
         -ItemType SymbolicLink -Value "$home\dotfiles\src\autohotkey\ljfs.ahk"  -Force