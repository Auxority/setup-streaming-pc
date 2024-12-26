# Enable script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Check if Winget is installed
if (!(Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not available. Please ensure your system is up-to-date."
    exit 1
}

# Update Winget sources
Write-Host "Updating Winget sources..."
winget source update

# Function to check if an app is already installed
function IsAppInstalled {
    param (
        [string]$appId
    )
    $installedApps = winget list --id $appId -q
    return $null -ne $installedApps
}

# Install apps from apps.txt, skipping those already installed
Write-Host "Installing apps from apps.txt..."
Get-Content -Path "apps.txt" | ForEach-Object {
    if (IsAppInstalled $_) {
        Write-Host "$_ is already installed. Skipping..."
    } else {
        Write-Host "Installing $_..."
        # winget install --id $_ --silent
    }
}

# Install Freeshow using the ./install_freeshow.ps1 script
Write-Host "Installing Freeshow..."
./installers/freeshow.ps1
