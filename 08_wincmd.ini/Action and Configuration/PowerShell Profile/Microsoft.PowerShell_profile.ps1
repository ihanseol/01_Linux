# Microsoft.PowerShell_profile.ps1

# Equivalent of 'ls' with color and classification
function ls { Get-ChildItem -Force | Format-Table -AutoSize }


# Equivalent of 'll'
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

# Equivalent of 'la'
function la {Get-ChildItem | Format-Wide }

# Equivalent of 'l'
function l { Get-ChildItem | Format-Table -AutoSize }

# Equivalent of 'vdir'
function vdir { Get-ChildItem | Format-List }

# Creating aliases for these functions
New-Alias -Name l -Value ls


