$ErrorActionPreference = 'Stop'

Confirm-Win10 -ReqBuild 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/644925942.exe'
  checksum64     = '96613c8e39537895f41521e0925cc5f9b625f831a3ff8ec8545fc1d4eda4d2c8'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
