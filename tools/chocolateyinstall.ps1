$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$packageName = $env:ChocolateyPackageName
$fileName = 'Messenger.170.0.0.24.92.exe'

$filePath = Join-Path -Path "$(Get-PackageCacheLocation)" -ChildPath $fileName

$downloadArgs = @{
  packageName    = $packageName
  fileFullPath   = $filePath
  url64bit       = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
  checksum64     = 'abb8d24d429e852018f2b9d1a0c23e57527cda1cd3bb38d384b034f30a06ce49'
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
