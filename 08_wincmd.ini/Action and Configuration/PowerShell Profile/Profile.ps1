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


function Run-ExternalScript {
    param(
        [string]$ScriptPath
    )

    # Check if the script file exists
    if (-not (Test-Path $ScriptPath)) {
        Write-Host "Script file '$ScriptPath' not found."
        return
    }

    # Execute the script
    & $ScriptPath
}

function chris {
    param(
        [string]$ScriptPath
    )

    New-Variable -Name MyString -Value "c:\Users\minhwasoo\Documents\WindowsPowerShell\windows_optimizer_by_chris.ps1" -Option Constant

    # Check if the script file exists
    if (-not (Test-Path $ScriptPath)) {
        Write-Host "Script file '$ScriptPath' not found. So set to default path ..."
        $ScriptPath = $MyString
    }

    # Execute the script
    & $ScriptPath
}


function Set-StringConstant {
    param (
        [string]$ConstantValue
    )

    # Define the constant variable within the function
    New-Variable -Name MyConstant -Value $ConstantValue -Option Constant

    # Optionally, you can output the constant value
    Write-Output "Constant value set to: $MyConstant"
}



# Equivalent of 'l'
function l { Get-ChildItem | Format-Table -AutoSize }

# Equivalent of 'vdir'
function vdir { Get-ChildItem | Format-List }



# Creating aliases for these functions
New-Alias -Name l -Value ls
New-Alias -Name lw -Value la
New-Alias -Name vi -Value vim



