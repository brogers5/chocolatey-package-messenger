$ErrorActionPreference = 'Stop'

Confirm-Win10 -ReqBuild 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/607660912.exe'
  checksum64     = 'a446532172c9c179f622878b75f240dfed1ffb75c3730d7799a7a7891a9df111'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
