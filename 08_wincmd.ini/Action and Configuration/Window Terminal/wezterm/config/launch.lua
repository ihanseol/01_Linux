local platform = require('utils.platform')

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   -- options.default_prog = { 'pwsh', '-NoLogo' }
   options.default_prog = { 'cmd' }
   -- options.default_prog = { 'c:\\msys64\\usr\\bin\\bash.exe', '-l' }
   options.launch_menu = {
      { label = 'PowerShell Core', args = { 'pwsh', '-NoLogo' } },
      { label = 'PowerShell Desktop', args = { 'powershell' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      { label = 'Nushell', args = { 'nu' } },
      { label = 'Msys2', args = { 'msys2_shell.cmd', '-ucrt' } },
      { label = 'Msys2 ZSH', args = { 'c:\\msys64\\usr\\bin\\zsh.exe', '-l' } },
      { label = 'Msys2 bash', args = { 'c:\\msys64\\usr\\bin\\bash.exe', '-l' } },
      {
         label = 'Git Bash',
         args = { 'c:\\msys64\\usr\\bin\\bash.exe', '-l' },
         -- args = { 'C:\\Users\\kevin\\scoop\\apps\\git\\current\\bin\\bash.exe' },
      },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'bash', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options


