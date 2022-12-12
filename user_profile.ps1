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

# Modify behivior of the pws
Set-Alias -Name t -Value tabRenameFN

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
        $this.ProfileName = "Windows Powershell"
        $this.Size = 0.5;
    }

    Pane([string]$command, [string]$orientation) : base($command) {
        $this.Orientation = $orientation;
        $this.ProfileName = "Windows Powershell"
        $this.Size = 0.5;
    }

    Pane([string]$command, [string]$orientation, [decimal]$size) : base($command) {
        $this.Orientation = $orientation;
        $this.ProfileName = "Windows Powershell"
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
      $this.ProfileName = "¨powershell";
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
                    AddPane("powershell", '-H', 0.25).
                    AddPane("powershell", '-V', 0.5).
                    MoveFocus("up");
  start wt $paneManagerClass;
}

# Create .gitignore file using this command:
# welc > .gitignore
Set-Alias -Name welc -Value welcFn
Set-Alias -Name cheat -Value cheatFn

Import-Module C:\Users\rmoreno\.config\powershell\gitIgnore.ps1

Import-Module C:\Users\rmoreno\.config\powershell\cheatmodes4.ps1

# Clear console when start
Clear-Host;

# put me in dev path at start
z dev;
