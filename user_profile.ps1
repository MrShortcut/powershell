using namespace System.Collections.Generic
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

# Tools
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
Set-Alias -Name miduco -Value miducoFN 
Set-Alias -Name ppa  -Value ppathFN # copy pwd to clip
Set-Alias -Name palp  -Value palFN # print aliases
Set-Alias -Name pal  -Value palPS1FN # print aliases

function palfn {
    $filepath = "$env:USERPROFILE\.config\powershell\aliasses.txt"  # reemplaza con la ruta correcta a tu archivo de aliases
    $aliases = get-content $filepath
    $aliases | out-host
}

function palPS1fn {
    $filepath = "$env:USERPROFILE\.config\powershell\aliasses.ps1"
    if (Test-Path $filePath) {
        $commands = Get-Content $filePath
        foreach ($command in $commands) {
            Invoke-Expression $command
        }
    } else {
        Write-Output "El archivo 'aliasses.ps1' no se encontró en la ubicación especificada."
    }
}

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
  Write-Output "git commit -m $v`""
  git commit -m $v
}

function cdFN ($v = '.') {
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
  cheatmodes
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
  npm start
  #nativefier $p -n $n -i $i
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

function ppathFN {
  (pwd | Select-Object -Last 1).Path | clip
  Write-Host 'Path copiado satisfactoriamente!'
}

# --------------------------------------------------------------------- @Miduco ---------------------------------------------------------------------
Set-Alias -Name gmidu -Value gmiduco
Set-Alias -Name gF -Value gcmeFeat
Set-Alias -Name gfix -Value gcmeFix
Set-Alias -Name gperf -Value gcmePerf
Set-Alias -Name gref -Value gcmeRef
Set-Alias -Name gdocs -Value gcmeDocs
Set-Alias -Name gtest -Value gcmeTest
Set-Alias -Name gbuild -Value gcmeBuild

function Highlight-Text($text, $color) {
    $colors = @{
        'Black'       = 0
        'DarkBlue'    = 1
        'DarkGreen'   = 2
        'DarkCyan'    = 3
        'DarkRed'     = 4
        'DarkMagenta' = 5
        'DarkYellow'  = 6
        'Gray'        = 7
        'DarkGray'    = 8
        'Blue'        = 9
        'Green'       = 10
        'Cyan'        = 11
        'Red'         = 12
        'Magenta'     = 13
        'Yellow'      = 14
        'White'       = 15
    }

    $colorCode = $colors[$color]
    if (-not $colorCode) {
        Write-Host "Invalid color specified: $color" -ForegroundColor Red
        return
    }

    $escapedColor = [char]27 + "[38;5;${colorCode}m"
    $resetColor = [char]27 + "[0m"

    $highlightedText = $text -replace "($text)", "${escapedColor}`$1${resetColor}"
    Write-Host $highlightedText
}

function Highlight-T($text, $highlight, $color) {
    $startIndex = $text.IndexOf($highlight)
    $endIndex = $startIndex + $highlight.Length

    Write-Host -NoNewline $text.Substring(0, $startIndex)
    Write-Host -NoNewline $highlight -ForegroundColor $color
    Write-Host $text.Substring($endIndex)
}

function gmiduco {
  #Write-Output "gM - para sacar este menú de comandos"
  #Write-Host "○ gF     🆕 feat     · Add new feature" -ForegroundColor Yellow
  #Highlight-Text "○ gF     🆕 feat     · Add new feature" "Yellow"
  #Write-Output "○ gperf  ⚡️perf     · Improve performance"
  #Write-Output "○ gref   🛠  refactor · Refactor code"
  #Write-Output "○ gdocs  📚 docs     · Add or update documentation"
  #Write-Output "○ gtest  🧪 test     · Add or update tests"
  #Write-Output "○ gbuild 🏗️ build    · Add or update build scripts"

  Highlight-Text "gmidu - para sacar este menú de comandos" "DarkGray"
  Write-Host "`n`COMANDOS & TIPOS DE COMMIT: `n` " -ForegroundColor Cyan 
  Highlight-T "gF     | 🆕 feat     · Add new feature" "gF" "Yellow"
  Highlight-T "gfix   | 🐛 fixed    · Submit a fixed to a bug" "gfix" "Green"
  Highlight-T "gperf  | ⚡️perf     · Improve performance" "gperf" "Blue"
  Highlight-T "gref   | 🛠  refactor · Refactor code" "gref" "Magenta"
  Highlight-T "gdocs  | 📚 docs     · Add or update documentation" "gdocs" "White"
  Highlight-T "gtest  | 🧪 test     · Add or update tests" "gtest" "DarkRed"
  Highlight-T "gbuild | 🏗️ build    · Add or update build scripts" "gbuild" "DarkGreen"
  Write-Host 
}

function gcmeFeat ($v) {
  Write-Output "git commit -m `"🆕 feat: $v`""
  git commit -m "🆕 feat: $v"
}

function gcmeFix ($v) {
  Write-Output "git commit -m `"🐛 fix: $v`""
  git commit -m "🐛 fix: $v"
}

function gcmePerf ($v) {
  Write-Output "git commit -m `"⚡️perf: $v`""
  git commit -m "⚡️perf: $v"
}

function gcmeRef ($v) {
  Write-Output "git commit -m `"🛠 refactor: $v`""
  git commit -m "🛠 refactor: $v"
}

function gcmeDocs ($v) {
  Write-Output "git commit -m `"📚 docs: $v`""
  git commit -m "📚 docs: $v"
}

function gcmeTest ($v) {
  Write-Output "git commit -m `"🧪 test: $v`""
  git commit -m "🧪 test: $v"
}

function gcmeBuild ($v) {
  Write-Output "git commit -m `"🏗️ build: $v`""
  git commit -m "🏗️ build: $v"
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @Miduco ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# --------------------------------------------------------------------- @Git ---------------------------------------------------------------------
Set-Alias -Name g -Value git
Set-Alias gs gist
Set-Alias ga. gitaddDot
Set-Alias -Name ga -Value gitaddspread
Set-Alias -Name grsurl -Value grsurlFN
Set-Alias -Name gpof -Value gpofFN
Set-Alias -Name gco -Value gcme
Set-Alias -Name ginit -Value gitInit
Set-Alias -Name gll -Value gitll
Set-Alias -Name gpob -Value gpobFN
Set-Alias -Name gdiff -Value gdiffFN
Set-Alias -Name gcoa -Value gcoaFN
Set-Alias -Name gpush -Value gitPushFn
Set-Alias -Name gllt -Value gitLogHistTakuyaFn
Set-Alias -Name gllf -Value gitLogTakuyaFn
Set-Alias -Name gpusht -Value gitPushTakuyaFn
Set-Alias -Name gpu -Value gitPushTakuyaFnFinal
Set-Alias -Name open -Value gitOPENTakuyaFn
Set-Alias -Name gtestT -Value gtestFn

function gitLogHistTakuyaFn ($v) {
  if($v) {
    git log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate -$v
  } else {
    git log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all
  }
}

function gitLogTakuyaFn ($p) {
  if($p) {
    git log --graph --name-status --pretty=format:\"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset\" --date=relative --decorate -$p
  } else {
    git log --graph --name-status --pretty=format:\"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset\" --date=relative
  }
}

function gitPushTakuyaFn {
  git push origin (git rev-parse --abbrev-ref HEAD)
}

function gitPushTakuyaFnFinal {
  git pull origin develop && git push origin (git rev-parse --abbrev-ref HEAD)
}

function gitOPENTakuyaFn {
  $remoteUrl = git remote get-url origin
  $baseUrl = $remoteUrl -replace "git@(.*):(.*)\.git", "https://`$1/`$2"
  $branch = git rev-parse --abbrev-ref HEAD
  $url = "$baseUrl"
  Start-Process $url
}

function gtestFn {
  git log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all | Select-String "commit" | ForEach-Object { $_.ToString().Split()[1] }
}

function gcoaFN ($p) {
  git commit --amend $p
}

function gitaddspread {
  param (
    [Parameter(Mandatory=$true, Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$files
  )

  foreach ($file in $files) {
    git add $file
  }
  git status
  gmidu
}

function gitaddDot ($p) {
  git add $p
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

function gitPushFn {
  git push
}

function gist {
  git status
  Highlight-Text "--------------------------" "DarkGray"
  Highlight-Text "pal - para sacar los alias" "Yellow"
  Highlight-Text "--------------------------" "DarkGray"
  gmidu
}

function gitInit {
  git init
}

function gdiffFn {
  git diff --color-words
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @Git ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Commans
function nrdFN {
  npm run dev
}

# --------------------------------------------------------------------- @Open files ---------------------------------------------------------------------
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

function miducoFN {
  npx miduco@latest
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @Open files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Modify behivior of the pws
Set-Alias -Name t -Value tabRenameFN

# --------------------------------------------------------------------- @Modify Paths ---------------------------------------------------------------------
Set-Alias -Name rmf -Value removeForceFN

function removeForceFN ($param) {
  if (-not [string]::IsNullOrWhiteSpace($param)) {
    $confirmation = Read-Host '¿Estás seguro de que deseas eliminar el archivo? (Y/N)'
    if ($confirmation -eq 'Y') {
      Write-Output ('Eliminando... ' + $param)
      Remove-Item -Force $param
    } else {
      Write-Output 'Eliminacion cancelada'
    }
  } else {
    Write-Output 'Ningún archivo para eliminar.'
  }
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ @Modify Paths ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Logic for PaneComannder
# Encapsulate an arbitrary command
class PaneCommand {
    [string]$Command

    PaneCommand() {
        $this.Command = "";
    }

    PaneCommand([string]$command) {
        $this.Command = $command
    }

    [string]GetCommand() {
        return $this.Command
    }

    [string]ToString() {
        return $this.GetCommand();
    }
}

# A proxy for Split Pane which takes in a command to run inside the pane
class Pane : PaneCommand {
    [string]$ProfileName;
    [string]$Orientation
    [decimal]$Size;

    Pane([string]$command) : base($command) {
        $this.Orientation = '';
        $this.ProfileName = "pwsh"
        $this.Size = 0.5;
    }

    Pane([string]$command, [string]$orientation) : base($command) {
        $this.Orientation = $orientation;
        $this.ProfileName = "pwsh"
        $this.Size = 0.5;
    }

    Pane([string]$command, [string]$orientation, [decimal]$size) : base($command) {
        $this.Orientation = $orientation;
        $this.ProfileName = "pwsh"
        $this.size = $size;
    }

    Pane([string]$ProfileName, [string]$command, [string]$orientation, [decimal]$size) : base($command) {
        $this.Orientation = $orientation;
        $this.ProfileName = $ProfileName;
        $this.size = $size;
    }

    [string]GetCommand() {
        return 'split-pane --size {0} {1} -p "{2}" -c {3}' -f $this.Size, $this.Orientation, $this.ProfileName, $this.Command
    }
}

class TargetPane : PaneCommand {
    [int]$SelectedIndex;

    TargetPane([int]$index) {
        $this.SelectedIndex = $index;
    }

    [string]GetCommand() {
        return "focus-pane --target={0}" -f $this.SelectedIndex;
    }
}

class MoveFocus : PaneCommand {
    [string]$direction;

    MoveFocus([string]$direction) {
        $this.direction = $direction;
    }

    [string]GetCommand() {
        return 'move-focus --direction {0}' -f $this.direction;
    }
}

class PaneManager : PaneCommand {
  [string]$InitialCommand;
  [List[PaneCommand]]$PaneCommands;
  [string]$ProfileName;
  [string]$DefaultOrientation;
  [float]$DefaultSize;

  PaneManager() {
      $this.PaneCommands = [List[PaneCommand]]::new();
      $this.ProfileName = "pwsh";
      $this.DefaultOrientation = '-V';
      $this.DefaultSize = 0.5;
      $this.InitialCommand = "--maximized"
  }

  PaneManager([string]$ProfileName) {
      $this.ProfileName = $ProfileName;
      $this.DefaultOrientation = '-V';
      $this.DefaultSize = 0.5;
  }

  [PaneManager]SetInitialCommand([string]$command) {
      $this.InitialCommand = $command;
      return $this;
  }

  [PaneManager]SetProfileName([string]$name) {
      $this.ProfileName = $name;
      return $this;
  }

  [PaneManager]SetDefaultOrientation([string]$orientation) {
      $this.DefaultOrientation = $orientation;
      return $this;
  }

  [PaneManager]SetDefaultSize([float]$size) {
      $this.DefaultSize = $size;
      return $this;
  }

  [PaneManager]SetOptions([string]$name, [string]$orientation, [float]$size) {
      return $this.SetProfileName($name)
              .SetDefaultOrientation($orientation)
              .SetDefaultSize($size);

  }

  [PaneManager]AddPane([PaneManager]$manager) {
      $manager.SetInitialCommand('');
      $this.AddCommand($manager);
      return $this;
  }

  [PaneManager]AddCommand([PaneCommand]$command) {
      $this.PaneCommands.Add($command);
      return $this;
  }

  [PaneManager]AddPane([string]$command, [string]$orientation, [decimal]$size) {
      $newPane = $this.MakePane(
          $this.ProfileName,
          $command,
          $orientation,
          $size
      );

      $this.AddCommand($newPane);
      return $this;
  }

  [Pane]MakePane($ProfileName, $command, $orientation, $size) {
      $newPane = [Pane]::new($ProfileName, $command, $orientation, $size);
      return $newPane;
  }

  [PaneManager]TargetPane([int]$index) {
      $targetCommand = [TargetPane]::new($index)
      $this.AddCommand($targetCommand)
      return $this;
  }

  [PaneManager]MoveFocus([string]$direction) {
      $targetCommand = [MoveFocus]::new($direction)
      $this.AddCommand($targetCommand)
      return $this;
  }

  [int]GetPaneCount() {
      $count = 0;
      foreach ($command in $this.PaneCommands)
      {
          if ($command -is [PaneManager]) {
              $count += $command.GetPaneCount();
          } elseif ($command -is [PaneCommand]) {
              $count += 1;
          }
      }

      return $count;
  }

  [string]GetCommand() {
      $joinedCommands = $this.PaneCommands -join "; ";

      if ($joinedCommands -eq "") {
          return $this.InitialCommand;
      }

      $finalCommand =  if ($this.InitialCommand -ne "") { "{0}; {1}" -f $this.InitialCommand, $joinedCommands} else { $joinedCommands };
      return $finalCommand
  }
}

# t command for open one instance of powershell divide in 3panes
function tabRenameFN {
  $culture = [System.Globalization.CultureInfo]::CreateSpecificCulture("en-US")
  $culture.NumberFormat.NumberDecimalSeparator = "."
  $culture.NumberFormat.NumberGroupSeparator = ","
  [System.Threading.Thread]::CurrentThread.CurrentCulture = $culture

  $paneManagerClass = ([PaneManager]::new()).
                    AddPane("pwsh", '-H', 0.25).
                    AddPane("pwsh", '-V', 0.5).
                    MoveFocus("up");
  start wt $paneManagerClass;
}

#---------------------- [LOGGER]/[END_LOGGER]-----------------------------------------------------
function Write-Log {
    param (
        [string]$message,
        [string]$level = "INFO",
        [string]$logFile = "log.txt",
        [string]$levelColor = "White",
        [string]$messageColor = "White",
        [switch]$D
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[${timestamp}] [${level}] ${message}"
    
    # Define los códigos de escape de colores
    $colorCodes = @{
        "Black" = "30"
        "Red" = "31"
        "Green" = "32"
        "Yellow" = "33"
        "Blue" = "34"
        "Magenta" = "35"
        "Cyan" = "36"
        "White" = "37"
    }
    
    if ($colorCodes.ContainsKey($levelColor)) {
        $levelColorCode = $colorCodes[$levelColor]
        $startLevelColor = "`e[${levelColorCode}m"
        $endLevelColor = "`e[0m"
        
        # Agrega los códigos de escape de colores al nivel del registro
        $logEntry = $logEntry -replace $level, "${startLevelColor}$level${endLevelColor}"
    }
    
    if ($colorCodes.ContainsKey($messageColor)) {
        $messageColorCode = $colorCodes[$messageColor]
        $startMessageColor = "`e[${messageColorCode}m"
        $endMessageColor = "`e[0m"
        
        # Agrega los códigos de escape de colores al mensaje del registro
        #$logEntry = $logEntry -replace $message, "${startMessageColor}$message${endMessageColor}"
        #$logEntry = $logEntry -replace [regex]::Escape($message), "${startMessageColor}$message${endColor}"
        if ($D) {
            $logEntry = $logEntry -replace [regex]::Escape($message), "${startMessageColor}$message${endColor}"
        }
        else {
          $logEntry = $logEntry -replace $message, "${startMessageColor}$message${endMessageColor}"
        }
    }
    
    Write-Host $logEntry  # Imprime el registro en la consola
    
    # Escribe el registro en el archivo de registro
    Add-Content -Path $logFile -Value $logEntry
}

#-----------------------------------------------------¬
#| Ejemplo de uso del logger con colores personalizados|
#------------------------------------------------------
#Write-Log "Este es un mensaje de información" -level "INFO" -levelColor "White" -messageColor "White"
#Write-Log "¡E! Algo salió mal" -level "ERROR" -levelColor "Red" -messageColor "White"
#Write-Log "Mensaje de advertencia" -level "WARNING" -levelColor "White" -messageColor "Yellow"
#---------------------- [LOGGER]/[END_LOGGER]-----------------------------------------------------

#---------------------- [YOUTUBE]/[DOWNLOADER]-----------------------------------------------------
#$VIDEO_ID = $args[0]

#if (-not $VIDEO_ID) {
#    Write-Host "ERROR: No video ID specified"
#    exit 1
#}

#Write-Log "videoID: $VIDEO_ID" -level "LOGGER" -levelColor "White" -messageColor "Yellow"

#$command = "yt-dlp"
#$arguments = "https://www.youtube.com/watch?v=$VIDEO_ID", "--format", "m4a", "-o", "./tmp/$($VIDEO_ID)s.%(ext)s"
#& $command $arguments 2>&1
#---------------------- [YOUTUBE]/[END_DOWNLOADER]-----------------------------------------------------


#---------------------- [SET_VARIABLES]/[END_SETVARIABLES]-----------------------------------------------------
# Set-Item -Path "Env:NOMBRE" -Value "CHEATMODES4"
Set-Alias -Name setVar -Value setEnvVar

# Set-Item -Path "Env:"transcribeApiKey -Value "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"
function setEnvVar ($nombre, $valor) {
  Set-Item -Path "Env:$nombre" -Value "$valor"
}
#---------------------- [SET_VARIABLES]/[END_SETVARIABLES]-----------------------------------------------------

# Create .gitignore file using this command:
# welc > .gitignore
Set-Alias -Name welc -Value welcFn
Set-Alias -Name cheat -Value cheatFn
Set-Alias -Name cheatM -Value cheatmodes

Import-Module $env:USERPROFILE\.config\powershell\gitIgnore.ps1

Import-Module $env:USERPROFILE\.config\powershell\cheatmodes4.ps1

# Clear console when start
cheatmodes
Start-Sleep -Seconds 1.618

Clear-Host;

# put me in dev path at start
#z dev;

# put me in isa path at start 
z isa;
