$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64bit       = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
  softwareName   = 'Messenger'
  checksum64     = '38e38a26e24a84b5605943ab3e7d354111c71f51e71299b5c3a89cf0db06b2b7'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  options        = @{
    Headers = @{
      'Sec-Fetch-Site' = 'none'
      'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36'
    }
  }
}

Install-ChocolateyPackage @packageArgs
