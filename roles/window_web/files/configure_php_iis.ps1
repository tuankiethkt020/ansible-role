# Cài đặt PHP nếu chưa có
if (-Not (Get-Command php -ErrorAction SilentlyContinue)) {
    choco install php -y
}

# Lấy đường dẫn php-cgi.exe
$phpPath = (Get-Command php-cgi.exe).Source
Write-Output "PHP Path: $phpPath"

# Kiểm tra nếu FastCGI đã có cấu hình PHP
$fcgiOutput = & "$env:windir\system32\inetsrv\appcmd.exe" list config -section:system.webServer/fastCgi | Out-String
if ($fcgiOutput -match [regex]::Escape($phpPath)) {
    Write-Output "FastCGI already exists. Skipping addition."
} else {
    & "$env:windir\system32\inetsrv\appcmd.exe" set config -section:system.webServer/fastCgi /+"[fullPath='$phpPath', arguments='', maxInstances='4', idleTimeout='300', activityTimeout='30', requestTimeout='90', instanceMaxRequests='10000', queueLength='1000']"
    Write-Output "FastCGI added."
}

# Kiểm tra nếu PHP Handler đã tồn tại
$handlerOutput = (Get-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/handlers" -name "." | Out-String)
if ($handlerOutput -match "PHP_via_FastCGI") {
    Write-Output "PHP Handler already exists. Skipping addition."
} else {
    try {
        Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/handlers" -name "." -value @{ 
            name="PHP_via_FastCGI"; 
            path="*.php"; 
            verb="*"; 
            modules="FastCgiModule"; 
            scriptProcessor="$phpPath" 
        }
        Write-Output "PHP Handler added."
    }
    catch {
        Write-Output "PHP Handler already exists (exception caught)."
    }
}

# Thêm index.php vào default document
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value="index.php"}
Write-Output "Default document set to index.php."

# Gán quyền cho IIS_IUSRS vào thư mục ansible-web
$webFolder = "C:\inetpub\wwwroot\ansible-web\ansible-web-main"
icacls $webFolder /grant "IIS_IUSRS:(OI)(CI)F" /T
Write-Output "Permissions set for IIS_IUSRS on $webFolder."

# Đảm bảo thư mục C:\inetpub\temp tồn tại
$sessionPath = "C:\inetpub\temp"
if (!(Test-Path $sessionPath)) {
    New-Item -ItemType Directory -Path $sessionPath -Force
    Write-Output "Created directory: $sessionPath"
} else {
    Write-Output "Directory already exists: $sessionPath"
}

# Gán quyền Modify cho IUSR và IIS_IUSRS trên C:\inetpub\temp
icacls $sessionPath /grant "IUSR:(OI)(CI)M" /grant "IIS_IUSRS:(OI)(CI)M" /T
Write-Output "Permissions set for IUSR and IIS_IUSRS on $sessionPath"

# Kiểm tra lại quyền bằng icacls
icacls $sessionPath

# Khởi động lại IIS
iisreset
