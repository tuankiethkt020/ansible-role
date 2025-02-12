################################################################################
##  File:  install_mysql.ps1
##  Desc:  Install MySQL CLI on Windows
################################################################################

# Set TLS to support modern HTTPS connections
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Define MySQL Installer URL
$mysqlDownloadUrl = "https://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-8.0.41.0.msi"
$installerPath = "C:\temp\mysql-installer.msi"

# Download MySQL Installer with User-Agent to avoid 403 errors
Write-Output "Downloading MySQL Installer from $mysqlDownloadUrl..."
Invoke-WebRequest -Uri $mysqlDownloadUrl -OutFile $installerPath -Headers @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
}

# Verify download success
if (!(Test-Path $installerPath)) {
    Write-Output "MySQL Installer download failed. Exiting..."
    exit 1
}

# Install MySQL
Write-Output "Installing MySQL Server..."
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait -NoNewWindow

# Verify installation
$mysqlPath = Get-Command mysql.exe -ErrorAction SilentlyContinue
if ($mysqlPath) {
    Write-Output "MySQL installation successful."
    mysql --version
} else {
    Write-Output "MySQL installation failed."
    exit 1
}
