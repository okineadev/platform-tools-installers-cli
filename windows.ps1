#!/usr/bin/env pwsh

# Enable TLSv1.2 for compatibility with older clients for current session
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# https://github.com/farag2/ADB-Debloating/blob/acc9a11a2688e0bb851c30a524b1f76f851f14eb/src/Download_ADB.ps1#L5-L10
if ($Host.Version.Major -eq 5) {
	# Progress bar can significantly impact cmdlet performance
	# https://github.com/PowerShell/PowerShell/issues/2138
	$Script:ProgressPreference = "SilentlyContinue"
}


# Solution for colored output in PowerShell:
# https://stackoverflow.com/a/78753310/21165921
#
# Color table:
# https://stackoverflow.com/a/28938235/21165921

# The Android™ logo is taken from: https://gist.github.com/okineadev/0cde43c0a2161212d28a6efd67fec442
# Android is a trademark of Google LLC.
Write-Host @"
$([char]27)[0;32m
         +++++                              +++++
        +++++++                            +++++++
         +++++++                          +++++++
          ++++++++                       +++++++
           ++++++++  ++++++++++++++++  ++++++++
            ++++++++++++++++++++++++++++++++++
             ++++++++++++++++++++++++++++++++
          ++++++++++++++++++++++++++++++++++++++
        ++++++++++++++++++++++++++++++++++++++++++
       ++++++++++++++++++++++++++++++++++++++++++++
     +++++++++++$([char]27)[0;30m**$([char]27)[0;32m+++++++++++++++++++++++$([char]27)[0;30m*$([char]27)[0;32m+++++++++++
    ++++++++++$([char]27)[0;30m%%%%#$([char]27)[0;32m++++++++++++++++++++$([char]27)[0;30m*%%%%$([char]27)[0;32m++++++++++
   ++++++++++$([char]27)[0;30m#%%%%#$([char]27)[0;32m++++++++++++++++++++$([char]27)[0;30m#%%%%#$([char]27)[0;32m++++++++++
  ++++++++++++$([char]27)[0;30m#%%*$([char]27)[0;32m++++++++++++++++++++++$([char]27)[0;30m*%%%$([char]27)[0;32m++++++++++++
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++$([char]27)[0m
"@

Write-Host
Write-Host "                 platform-tools installer"
Write-Host "               (C) Okinea Dev (2024-present)" -ForegroundColor DarkGray
Write-Host
Write-Host "This script will install platform-tools in `"C:\platform-tools`" and add it to PATH."

Write-Host

Write-Host -ForegroundColor Cyan "Please read the terms and conditions here: $([char]27)[4mhttps://developer.android.com/studio/terms$([char]27)[24m"
$agreement = Read-Host -Prompt "Do you agree with the terms? $([char]27)[1m(Y/n)$([char]27)[0m"

if ($agreement -notmatch '^(?i)y$') {
    Write-Host "❌ You must agree with the terms and conditions to proceed."
    Write-Host
    exit
}

$downloadUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
$destinationPath = "$env:TEMP\platform-tools-latest-windows.zip"
$extractPath = "C:\platform-tools"

Write-Host "📥 Downloading platform-tools..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath -Verbose


Write-Host "📦 Extracting platform-tools..."
Expand-Archive -Path $destinationPath -DestinationPath $extractPath -Force


$envPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($envPath -notlike "*$extractPath*") {
    Write-Host "Adding C:\platform-tools to system $([char]27)[1mPATH$([char]27)[0m..."
    $newPath = "$envPath;$extractPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
} else {
    Write-Host "ℹ️ C:\platform-tools is already in system $([char]27)[1mPATH$([char]27)[0m."
}

Remove-Item -Path $destinationPath -Force

Write-Host "✅ Installation complete. Please restart your computer to apply changes."
