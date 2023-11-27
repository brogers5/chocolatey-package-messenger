$ErrorActionPreference = 'Stop'

Confirm-Win10 -ReqBuild 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/541049797.exe'
  checksum64     = '26117a15b29c63a2caeed456e29f4dfbacd242633c319b1ac1e541bc4593447b'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
