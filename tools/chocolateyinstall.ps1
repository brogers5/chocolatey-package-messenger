$ErrorActionPreference = 'Stop'

Confirm-Win10 -ReqBuild 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/524147032.exe'
  checksum64     = '0fa597d8899b788820d329d345e79e509c02708721be8eaf861e4481c2382d44'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
