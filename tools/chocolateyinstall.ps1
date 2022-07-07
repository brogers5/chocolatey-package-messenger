$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64bit       = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
  softwareName   = 'Messenger'
  checksum64     = '74f43a0a808a071eab0be190c3b7a56efa703e0c02ffd4c527cb25a4e8194cef'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  options        = @{
    Headers = @{
      'Sec-Fetch-Site' = 'same-origin'
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36'
    }
  }
}

Install-ChocolateyPackage @packageArgs
