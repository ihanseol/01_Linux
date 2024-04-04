# Microsoft.PowerShell_profile.ps1

# Equivalent of 'ls' with color and classification
function ls { Get-ChildItem -Force | Format-Table -AutoSize }


# Equivalent of 'll'
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

# Equivalent of 'la'
function la {
    param(
        [Parameter(Position=0)]
        [string]$Name
    )

    # Check if $Name is null or empty
    if (-not $Name) {
        $Name = 3
    } else {
        # Try to convert $Name to an integer
        $intValue = 0
        if (![int]::TryParse($Name, [ref]$intValue)) {
            Write-Host "Invalid value provided for -Name. Defaulting to 3."
            $Name = 3
        } else {
            if ($intValue -lt 3 -or $intValue -gt 6) {
                Write-Host "Value provided for -Name is out of range (3-6). Defaulting to 3."
                $Name = 3
            } else {
                $Name = $intValue
            }
        }
    }

    Get-ChildItem | Format-Wide -Column $Name
}



# Equivalent of 'l'
function l { Get-ChildItem | Format-Table -AutoSize }

# Equivalent of 'vdir'
function vdir { Get-ChildItem | Format-List }

# Creating aliases for these functions
New-Alias -Name l -Value ls
New-Alias -Name lw -Value la
New-Alias -Name vi -Value vim



