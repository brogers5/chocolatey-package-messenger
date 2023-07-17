$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/494866009.exe'
  checksum64     = '124026c5dffa72711fd006fb968b4b4a8c0914213afb95f2ff4561a500ccb6f6'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
