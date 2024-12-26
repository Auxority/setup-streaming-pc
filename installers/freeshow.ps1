# Define the URL and the local path for the installer
$freeshowUrl = "https://github.com/ChurchApps/FreeShow/releases/download/v1.3.3/FreeShow-1.3.3-x64.exe"
$installerPath = "$env:TEMP\FreeShow-1.3.3-x64.exe"
$freeshowExePath = "$env:LOCALAPPDATA\Programs\freeshow\FreeShow.exe"

# Check if FreeShow is already installed
if (-Not (Test-Path $freeshowExePath)) {
    # Download the installer
    Start-BitsTransfer -Source $freeshowUrl -Destination $installerPath

    # Install Freeshow
    Start-Process -FilePath $installerPath -ArgumentList "/S" -Wait

    # Clean up the installer
    Remove-Item $installerPath
} else {
    Write-Output "FreeShow is already installed."
}
