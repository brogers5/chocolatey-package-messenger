$ErrorActionPreference = 'Stop'

Confirm-Win10 18362

$headers = @{
  'Sec-Fetch-Site' = 'none'
}
$userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.53 Safari/537.36'
$canonicalUri = 'https://www.messenger.com/messenger/desktop/downloadV2/?platform=win'
$canonicalResponse = Invoke-WebRequest -Uri $canonicalUri -Method Head -UserAgent $userAgent -Headers $headers -UseBasicParsing
$downloadUri = $canonicalResponse.BaseResponse.ResponseUri.AbsoluteUri

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64bit       = $downloadUri
  softwareName   = 'Messenger'
  checksum64     = 'd3ff5ef65f9a1ec375c3f151815ff397c9222c81026f7ba4229e322105048ff1'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
