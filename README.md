The first step in creating your own profile is to test if you already have a profile. Open PowerShell and type:
```sh
New-Item -Path $profile -Type File -Force
```

cd  C:\Users\rmoreno\Documents\WindowsPowerShell

```sh
nvim .\Microsoft.PowerShell_profile.ps1
insert this line -> . $env:USERPROFILE\.config\powershell\user_profile.ps1
```

nvim $PROFILE.CurrentUserCurrentHost
```ps1
. $env:USERPROFILE\.config\powershell\user_profile.ps1
```

Download Modules...

Install-Module posh-git -Scope CurrentUser -Force

Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module oh-my-posh 

```ps1
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```

scoop install nvm

Install-Module -Name Terminal-Icons -Repository PSGallery -Force

Install-Module -Name z -Force

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

Install-Module -Name PSFzf -Scope CurrentUser -Force

Set-PSReadLineOption -PredictionSource History

scoop install fzf

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

ok

---
##### .vscode\extensions

hacked-solarized-dark.css
path:

```js
...vscode\extensions\shd101wyy.markdown-preview-enhanced-0.8.13\crossnote\styles\preview_theme\solarized-dark.css
```
