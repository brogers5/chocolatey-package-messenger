[CmdletBinding()]
param($IncludeStream)
Import-Module AU
Import-Module Microsoft.PowerShell.SecretManagement

$sparkleUri = 'https://www.facebook.com/messenger/desktop/zeratul/update.xml?target=zeratul&platform=win'
$userAgent = 'Update checker of Chocolatey Community Package ''messenger'''

function global:au_BeforeUpdate($Package) {
    #Archive this version for future development, since the vendor does not guarantee perpetual availability
    $filePath = ".\Messenger.$($Latest.Version).exe"

    Invoke-WebRequest -Uri $Latest.Url64 -OutFile $filePath
    $Latest.Checksum64 = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash.ToLower()

    if ((Get-Command -Name 'vt' -CommandType Application -ErrorAction SilentlyContinue)) {
        vt.exe scan file "$filePath" --silent
    }
    else {
        Write-Warning 'VirusTotal CLI is not available - skipping VirusTotal submission'
    }

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            '(<packageSourceUrl>)[^<]*(</packageSourceUrl>)' = "`$1https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)`$2"
            '(\<copyright\>).*?(\<\/copyright\>)'            = "`${1}© Meta $(Get-Date -Format yyyy)`$2"
        }
        'tools\chocolateyinstall.ps1'   = @{
            '(^[$]?\s*url64bit\s*=\s*)(''.*'')'   = "`$1'$($Latest.Url64)'"
            '(^[$]?\s*checksum64\s*=\s*)(''.*'')' = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function Get-VersionInfo($ReleaseItem) {
    $sparkleVersion = $ReleaseItem.enclosure.version
    $shortVersionString = $releaseItem.enclosure.shortVersionString
    $splitVersionString = $shortVersionString.Split('.')
    $productVersion = "$($splitVersionString[0]).$($splitVersionString[1]).$sparkleVersion"

    return @{
        Url64   = "https://www.facebook.com/zeratul/desktop/update/$sparkleVersion.exe"
        Version = $productVersion
    }
}

function Get-LatestBetaVersionInfo {
    $webSession = New-Object -TypeName 'Microsoft.PowerShell.Commands.WebRequestSession'
    $cookieUri = 'https://www.facebook.com/'

    $facebookUserID = Get-Secret -Name 'Facebook User ID' -AsPlainText
    $c_userCookie = New-Object -TypeName 'System.Net.Cookie' -ArgumentList ('c_user', $facebookUserID)
    $c_userCookie.Secure = $true
    $webSession.Cookies.Add($cookieUri, $c_userCookie)

    $facebookSessionID = Get-Secret -Name 'Facebook Session ID' -AsPlainText
    $xsCookie = New-Object -TypeName 'System.Net.Cookie' -ArgumentList ('xs', $facebookSessionID)
    $xsCookie.Secure = $true
    $xsCookie.HttpOnly = $true
    $webSession.Cookies.Add($cookieUri, $xsCookie)

    $releaseItem = Invoke-RestMethod -Uri $sparkleUri -UserAgent $userAgent -WebSession $webSession -UseBasicParsing

    $versionInfo = Get-VersionInfo -ReleaseItem $releaseItem
    $versionInfo.Version += '-beta'

    return $versionInfo
}

function Get-LatestStableVersionInfo {
    $releaseItem = Invoke-RestMethod -Uri $sparkleUri -UserAgent $userAgent -UseBasicParsing
    return Get-VersionInfo -ReleaseItem $releaseItem
}

function global:au_GetLatest {
    $streams = [Ordered] @{
        Beta   = Get-LatestBetaVersionInfo
        Stable = Get-LatestStableVersionInfo
    }

    return @{ Streams = $streams }
}

Update-Package -ChecksumFor None -IncludeStream $IncludeStream -NoReadme
