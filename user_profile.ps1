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
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias .. cd..
Set-Alias vi nvim

Set-Alias -Name ex -Value exitFn 
Set-Alias -Name flush -Value flushdns
Set-Alias -Name touch -Value touchFn
Set-Alias -Name v -Value nvimFN 
Set-Alias -Name c -Value cdFN 
Set-Alias -Name dev -Value devFN
Set-Alias -Name e -Value eFN
Set-Alias -Name n -Value nFN
Set-Alias -Name ta -Value tFN
Set-Alias -Name tai -Value taiFN
Set-Alias -Name co -Value coFN
Set-Alias -Name nrd -Value nrdFN
Set-Alias -Name pass -Value passg 
Set-Alias -Name p -Value pnpmRunDevFn 

function pnpmRunDevFn {
  pnpm run dev
}

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function nvimFN {
  nvim .
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

function touchFn ($value) {
  new-Item -Name $value
}

function devFn {
  npm run dev
}

function exitFN {
  exit
}

function eFN {
  explorer .
}

function coFN {
  code .
}

function nFN ($p, $n, $i) {
  # url, name, ico
  nativefier $p -n $n -i $i
}

function tFN {
  Write-Output '<script src="https://cdn.tailwindcss.com"></script>'
}

function taiFN {
  Write-Output "
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [],
  theme: {
    extend: {},
  },
  plugins: [],
}
  " >> tailwind.config.js
}

# Git
Set-Alias g git
Set-Alias gs gist
Set-Alias ga. gitaddDot
Set-Alias -Name grsurl -Value grsurlFN
Set-Alias -Name gpof -Value gpofFN 
Set-Alias -Name gco -Value gcme 
Set-Alias -Name ginit -Value gitInit 
Set-Alias -Name gll -Value gitll 
Set-Alias -Name gpob -Value gpobFN 
Set-Alias -Name gdiff -Value gdiffFN 
Set-Alias -Name gcoa -Value gcoaFN 

function gcoaFN ($p) {
  git commit --amend $p
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

function gpobFN($p) {
  git push --set-upstream origin $p
}

function grsurlFN ($param) {
  git remote set-url origin $param
}

function gist {
  git status
}

function gitInit {
  git init
}

function gdiffFn {
  git diff --color-words
}

# Commans
function nrdFN {
  npm run dev
}

# Open files
Set-Alias -Name vimp -Value vimPackageFN
Set-Alias -Name vimr -Value vimReadmeFN
Set-Alias -Name vimg -Value vimIgnoreFN
Set-Alias -Name vimi -Value vimIndexFN
Set-Alias -Name vimw -Value vimWebpackFN
Set-Alias -Name vime -Value vimEditorconfigFN
Set-Alias -Name vimt -Value vimTsconfigFN
Set-Alias -Name vimu -Value vimUserProfileFN

function vimPackageFN {
  nvim package.json 
}

function vimReadmeFN {
  nvim README.md
}

function vimIgnoreFN {
  nvim .gitignore
}

function vimIndexFN {
  nvim index.js
}

function vimWebpackFN {
  nvim webpack.config.js
}

function vimEditorconfigFN {
  nvim .editorconfig
}

function vimTsconfigFN {
  nvim tsconfig.js
}

function vimUserProfileFN {
  nvim user_profile.ps1
}


# Create .gitignore file using this command:
# welc > .gitignore
Set-Alias -Name welc -Value welcFn
Set-Alias -Name cheat -Value cheatFn

Import-Module C:\Users\rmoreno\.config\powershell\gitIgnore.ps1

Import-Module C:\Users\rmoreno\.config\powershell\cheatmodes4.ps1

