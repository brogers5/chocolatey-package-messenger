Import-Module AU

function global:au_BeforeUpdate($Package) {
    $Latest.Checksum64 = Get-RemoteChecksum -Url $Latest.Url64

    Set-DescriptionFromReadme -Package $Package -ReadmePath '.\DESCRIPTION.md'
}

function global:au_SearchReplace {
    @{
        "$($Latest.PackageName).nuspec" = @{
            '<packageSourceUrl>[^<]*</packageSourceUrl>' = "<packageSourceUrl>https://github.com/brogers5/chocolatey-package-$($Latest.PackageName)/tree/v$($Latest.Version)</packageSourceUrl>"
            '(\<copyright\>).*?(\<\/copyright\>)' = "`${1}© Meta $(Get-Date -Format yyyy)`$2"
        }
        'tools\chocolateyinstall.ps1' = @{
            '(^[$]?\s*checksum64\s*=\s*)(''.*'')' = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $uri = 'https://www.facebook.com/messenger/desktop/zeratul/update.xml?target=zeratul&platform=win'
    $userAgent = 'Update checker of Chocolatey Community Package ''messenger'''
    $releaseItem = Invoke-RestMethod -Uri $uri -UserAgent $userAgent -UseBasicParsing

    $sparkleVersion = $releaseItem.enclosure.version
    $splitVersionString = $releaseItem.enclosure.shortVersionString.Split('.')
    $productVersion = [Version] "$($splitVersionString[0]).$($splitVersionString[1]).$sparkleVersion"

    return @{
        Url64 = $releaseItem.enclosure.url
        Version = $productVersion
    }
}

Update-Package -ChecksumFor None -NoReadme
