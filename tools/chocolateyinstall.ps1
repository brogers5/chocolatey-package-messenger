$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  silentArgs     = '/S'
  url64bit       = 'https://www.facebook.com/zeratul/desktop/update/485154837.exe'
  checksum64     = '27b24fff042d98021fd10858d514efa0710b4fb185943655a9ef8ffb8e50763a'
  checksumType64 = 'sha256'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @installArgs
