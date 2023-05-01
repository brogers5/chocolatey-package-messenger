$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$packageName = $env:ChocolateyPackageName
$fileName = 'Messenger.185.0.0.5.228.exe'

$filePath = Join-Path -Path "$(Get-PackageCacheLocation)" -ChildPath $fileName

$downloadArgs = @{
  packageName    = $packageName
  fileFullPath   = $filePath
  url64bit       = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
  checksum64     = '59fc3a30bab5ac56a67cd3e191ca00487cae52fa943531f63349aacb923fa932'
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
