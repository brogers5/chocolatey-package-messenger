$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/510289419.exe'
  checksum64     = '4ffde1c575f99b33d0bc24d3a6b5c98e5780940834072d533d934c385fbc0abc'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
