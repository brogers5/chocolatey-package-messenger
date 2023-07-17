$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/495435242.exe'
  checksum64     = 'b38f97cb783e75e8d86142098403eb63eac07f40ff9f3fb5d34127c18997c7d8'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
