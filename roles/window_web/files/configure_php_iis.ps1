# Cài đặt PHP nếu chưa có
if (-Not (Get-Command php -ErrorAction SilentlyContinue)) {
    choco install php -y
}

# Lấy đường dẫn php-cgi.exe
$phpPath = (Get-Command php-cgi.exe).Source
Write-Output "PHP Path: $phpPath"

# Kiểm tra nếu FastCGI đã có cấu hình PHP
$fcgi = & "$env:windir\system32\inetsrv\appcmd.exe" list config -section:system.webServer/fastCgi
if ($fcgi -notmatch [regex]::Escape($phpPath)) {
    & "$env:windir\system32\inetsrv\appcmd.exe" set config -section:system.webServer/fastCgi /+"[fullPath='$phpPath', arguments='', maxInstances='4', idleTimeout='300', activityTimeout='30', requestTimeout='90', instanceMaxRequests='10000', queueLength='1000']"
    Write-Output "FastCGI added."
} else {
    Write-Output "FastCGI already exists."
}

# Kiểm tra nếu PHP Handler đã tồn tại
$handlerExists = Get-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/handlers" -name "." | Where-Object { $_.name -eq "PHP_via_FastCGI" }
if (-Not $handlerExists) {
    Add-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/handlers" -name "." -value @{ 
        name="PHP_via_FastCGI"; 
        path="*.php"; 
        verb="*"; 
        modules="FastCgiModule"; 
        scriptProcessor="$phpPath" 
    }
    Write-Output "PHP Handler added."
} else {
    Write-Output "PHP Handler already exists."
}

# Thêm index.php vào default document
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/defaultDocument/files" -name "." -value @{value="index.php"}
Write-Output "Default document set to index.php."

# Gán quyền cho IIS_IUSRS vào thư mục ansible-web
$webFolder = "C:\inetpub\wwwroot\ansible-web\ansible-web-main"
icacls $webFolder /grant "IIS_IUSRS:(OI)(CI)F" /T
Write-Output "Permissions set for IIS_IUSRS on $webFolder."

# Khởi động lại IIS
iisreset
