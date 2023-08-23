#[ CHEATMODE ]
const vim = {
  vim: nvim,
  ll: ls,
  grep: findstr,
  tig: 'C:\Program Files\Git\usr\bin\tig.exe',
  less: 'C:\Program Files\Git\usr\bin\less.exe',
  [ '..' ]: [ 'cd..' ],
  vi: nvim,
}

#[ TOOLS ]
ex - Value exitFn                      #
flush - Value flushdns                 #
touch - Value touchFn                  #
v - Value nvimFN                       #
c - Value cdFN                         #
dev - Value devFN                      #
e - Value eFN                          #
n - Value nFN                          #
ta - Value tFN                         #
tai - Value taiFN                      #
co - Value coFN                        #
nrd - Value nrdFN                      #
pass - Value passg                     #
p - Value pnpmRunDevFn                 #
miduco - Value miducoFN                #
ppa - Value ppathFN                   # copy pwd to clip #
pal - Value palFN                     # print aliases #

#[ MIDUCO ]
gmidu - Value gmiduco                  #
gF - Value gcmeFeat                    #
gfix - Value gcmeFix                   #
gperf - Value gcmePerf                 #
gref - Value gcmeRef                   #
gdocs - Value gcmeDocs                 #
gtest - Value gcmeTest                 #
gbuild - Value gcmeBuild               #

#[ GIT ]
g - Value git                          #
 gs gist                                     #
ga.gitaddDot                               #
ga - Value gitaddspread                #
grsurl - Value grsurlFN                #
gpof - Value gpofFN                    #
gco - Value gcme                       #
ginit - Value gitInit                  #
gll - Value gitll                      #
gpob - Value gpobFN                    #
gdiff - Value gdiffFN                  #
gcoa - Value gcoaFN                    #
gpush - Value gitPushFn                #
gllt - Value gitLogHistTakuyaFn        #
gllf - Value gitLogTakuyaFn            #
gpusht - Value gitPushTakuyaFn         #
open - Value gitOPENTakuyaFn           #
gtestT - Value gtestFn                 #

#[ VIM OPEN FILES]
vimp - Value vimPackageFN              #
vimr - Value vimReadmeFN               #
vimg - Value vimIgnoreFN               #
vimi - Value vimIndexFN                #
vimw - Value vimWebpackFN              #
vime - Value vimEditorconfigFN         #
vimt - Value vimTsconfigFN             # vim./.editorconfig
vimu - Value vimUserProfileFN          # vim./ user_profile.ps1

setVar - Value setEnvVar               # set env var

# Create .gitignore file using this command:

# welc > .gitignore

welc - Value welcFn                    # welc > .gitignore
cheat - Value cheatFn                  # print cheatmodes
cheatM - Value cheatmodes              # print cheatmodes
