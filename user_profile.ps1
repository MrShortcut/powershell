# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

Import-Module posh-git
$omp_config = Join-Path $PSScriptRoot ".\takuya.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias co code
Set-Alias e explorer 
Set-Alias .. cd..
Set-Alias vi nvim
Set-Alias gs gist
Set-Alias ga. gitaddDot

Set-Alias -Name gco -Value gcme 
Set-Alias -Name ex -Value exitFn 
Set-Alias -Name gll -Value gitll 
Set-Alias -Name flush -Value flushdns
Set-Alias -Name touch -Value touchFn
Set-Alias -Name gin -Value gitInit 
Set-Alias -Name v -Value nvimFN 
Set-Alias -Name c -Value cdFN 
Set-Alias -Name gpof -Value gpofFN 


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function gist {
  git status
}

function nvimFN {
  nvim .
}

function gitInit {
  git init
}

function flushdns {
  ipconfig /flushdns
}

function gcme ($v) {
  git commit -m $v 
}

function cdFN ($v) {
  cd $v
  ls
}

function gitaddDot ($p) {
  git add .
}

function gitll {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

function gpofFN {
  git push --set-upstream origin main
}

function touchFn ($value) {
  new-Item -Name $value
}

function exitFN {
  exit
}


# Create .gitignore file using this command:
# welc > .gitignore
Set-Alias -Name welc -Value welcFn
Set-Alias -Name cheat -Value cheatFn

Import-Module C:\Users\rmoreno\.config\dotfiles-public\.config\powershell\gitIgnore.ps1

Import-Module C:\Users\rmoreno\.config\dotfiles-public\.config\powershell\cheatmodes4.ps1

