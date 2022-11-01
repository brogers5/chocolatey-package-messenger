$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$packageName = $env:ChocolateyPackageName
$fileName = 'Messenger.167.0.0.18.104.exe'

$filePath = Join-Path -Path "$(Get-PackageCacheLocation)" -ChildPath $fileName

$downloadArgs = @{
  packageName    = $packageName
  fileFullPath   = $filePath
  url64bit       = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
  checksum64     = '6d31c154de2cf93a2a52e96f0fbe0827e0c4386222d3b8495773e654cee45405'
  checksumType64 = 'sha256'
  options        = @{
    Headers = @{
      'Sec-Fetch-Site' = 'none'
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36'
    }
  }
}

Get-ChocolateyWebFile @downloadArgs

$installArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file64         = $filePath
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @installArgs
