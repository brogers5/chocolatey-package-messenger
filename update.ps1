Import-Module AU

function global:au_BeforeUpdate($Package) {
    #Archive this version for future development, since the vendor does not guarantee perpetual availability
    $filePath = ".\Messenger.$($Latest.Version).exe"
    Invoke-WebRequest -Uri $Latest.Url64 -OutFile $filePath
    $Latest.Checksum64 = (Get-FileHash -Path $filePath -Algorithm SHA256).Hash.ToLower()

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            '(<packageSourceUrl>)[^<]*(</packageSourceUrl>)' = "`$1https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)`$2"
            '(\<copyright\>).*?(\<\/copyright\>)'            = "`${1}© Meta $(Get-Date -Format yyyy)`$2"
        }
        'tools\chocolateyinstall.ps1'   = @{
            '(^[$]?\s*fileName\s*=\s*)(''.*'')'   = "`$1'Messenger.$($Latest.ShortVersionString).exe'"
            '(^[$]?\s*checksum64\s*=\s*)(''.*'')' = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $uri = 'https://www.facebook.com/messenger/desktop/zeratul/update.xml?target=zeratul&platform=win'
    $userAgent = 'Update checker of Chocolatey Community Package ''messenger'''
    $releaseItem = Invoke-RestMethod -Uri $uri -UserAgent $userAgent -UseBasicParsing

    $sparkleVersion = $releaseItem.enclosure.version
    $shortVersionString = $releaseItem.enclosure.shortVersionString
    $splitVersionString = $shortVersionString.Split('.')
    $productVersion = "$($splitVersionString[0]).$($splitVersionString[1]).$sparkleVersion"

    return @{
        ShortVersionString = $shortVersionString
        Url64              = $releaseItem.enclosure.url
        Version            = $productVersion
    }
}

Update-Package -ChecksumFor None -NoReadme
