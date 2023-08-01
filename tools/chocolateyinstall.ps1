$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/499116866.exe'
  checksum64     = '04eb6bfdf7e8574793c74d0a0aa842108dc054ba8e2d2f8d25efc53785e0065e'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
