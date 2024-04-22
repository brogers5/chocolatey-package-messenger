$ErrorActionPreference = 'Stop'

Confirm-Win10 -ReqBuild 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/590569097.exe'
  checksum64     = 'dca75b69e2c6985ad5ee938713e93a593888e65c06a61db6675eb0eab5223bb1'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
