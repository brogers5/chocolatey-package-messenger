[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

# ⛔️ DEPRECATED

Development for this Chocolatey package has been discontinued.

Facebook has unfortunately opted to phase out the native Windows application consumed by this package in favor of [an Edge-powered progressive web app (PWA) that is distributed via the Microsoft Store](https://www.microsoft.com/p/messenger/9wzdncrf0083). Unfortunately, Chocolatey CLI currently lacks support for managing Microsoft Store applications, so I am unable to migrate the package to this version. Given that there are no near-term plans to implement this, I do not have a path forward for maintaining this package any longer.

While older versions of Messenger may still be downloaded, Facebook has also implemented a kill switch that either blocks use of an older version (upon launching or after logging in), or prevents users from logging in successfully. Since this effectively makes the application itself useless, I have unlisted all previously published versions from the Community Repository.

This repository will remain online only for archival purposes. Note that I do not have redistribution rights for Messenger, so any copies of the package published here are functionally dependent on Facebook continuing to host older installers for Messenger on their servers. Therefore, I cannot guarantee they will continue to work indefinitely.

---
 
# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-messenger@11eade7e5c9cf02a523fc1a90c744a146ba806b7/messenger.png" width="48" height="48"/> Chocolatey Package: [Messenger](https://community.chocolatey.org/packages/messenger)

[![Latest package version shield](https://img.shields.io/chocolatey/v/messenger.svg?include_prereleases)](https://community.chocolatey.org/packages/messenger)
[![Total package download count shield](https://img.shields.io/chocolatey/dt/messenger.svg)](https://community.chocolatey.org/packages/messenger)

## Install

[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved stable version from the Chocolatey Community Repository:

```shell
choco install messenger --source="'https://community.chocolatey.org/api/v2'"
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-messenger/releases). The `nupkg` can be installed from the current directory (with dependencies sourced from the Community Repository) as follows:

```shell
choco install messenger --source="'.;https://community.chocolatey.org/api/v2/'"
```

This package also supports the project's beta builds. Opt into these with the `--prerelease` switch.

## Build

[Install Chocolatey](https://chocolatey.org/install), clone this repository, and run the following command in the cloned repository:

```shell
choco pack
```

A successful build will create `messenger.x.y.z.nupkg`, where `x.y.z` should be the Nuspec's `version` value at build time.

Note that Chocolatey package builds are non-deterministic. Consequently, an independently built package will fail a checksum validation against officially published packages.

## Update

This package should be automatically updated by the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au). If it is outdated by more than a few days, please [open an issue](https://github.com/brogers5/chocolatey-package-messenger/issues).

### AU Setup

AU expects the parent directory that contains this repository to share a name with the Nuspec (`messenger`). Your local repository should therefore be cloned accordingly:

```shell
git clone git@github.com:brogers5/chocolatey-package-messenger.git messenger
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):

```shell
mklink /J messenger ..\chocolatey-package-messenger
```

### Beta Stream Setup

The update script will request the latest version information for both the stable and beta channels directly from Messenger's Sparkle service.

While information for the stable channel may be anonymously queried, the beta channel requires access to a Facebook account that has joined Messenger's beta testing program. Users can opt into this directly in Messenger - from the menu bar, browse to **File** > **Preferences** > **General**, and toggle **Join beta testing**:

![Screenshot of beta testing toggle](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-messenger@5010723f82c0b6b79779417af1bb1bee15001cc0/BetaTestingToggle.png)

Requests for beta version information will also require sending authentication cookies that contain the account's static user ID ([`c_user`](https://cookiedatabase.org/cookie/facebook/c_user/)) and a dynamic unique session ID ([`xs`](https://cookiedatabase.org/cookie/facebook/xs/)). We can take advantage of session riding to reuse an existing session ID from PowerShell and minimize authenticating to Facebook.

The script depends on [PowerShell's `SecretManagement` module](https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/) to securely query for the cookies' values from a registered extension vault.

If you do not already have an extension vault registered, install [an extension vault module](https://www.powershellgallery.com/packages?q=Tags%3A%22SecretManagement%22) of your choice, then [register a secret vault](https://learn.microsoft.com/powershell/module/microsoft.powershell.secretmanagement/register-secretvault?view=ps-modules) as required by the module's implementation.

Log into Facebook from your web browser, [grab the cookies' values](https://www.cookieyes.com/blog/how-to-check-cookies-on-your-website-manually/), then create the following secrets:

```powershell
#TODO: Populate using values sourced from web browser
$c_userValue = ''
$xsValue = ''

Set-Secret -Name 'Facebook User ID' -Secret $c_userValue
Set-Secret -Name 'Facebook Session ID' -Secret $xsValue
```

>[!NOTE]
>The session ID secret will require occasional updates to work around sessions expiring or otherwise being invalidated by Facebook (e.g. logging out, password changes, device removal, suspicious account activity, etc.).

### VirusTotal Setup

While not strictly necessary to produce a working package, it's recommended to [install VirusTotal's CLI](https://community.chocolatey.org/packages/vt-cli) and [configure an API key](https://virustotal.github.io/vt-cli/#configuring-your-api-key). An API key can be [procured for free with a VirusTotal account](https://docs.virustotal.com/docs/please-give-me-an-api-key).

This should enable automated submission of the installer binary to VirusTotal, which would improve the user experience for Chocolatey Pro+ users. They have access to Chocolatey's [Runtime Malware Protection feature](https://docs.chocolatey.org/en-us/features/virus-check), which by default is [enabled and configured for VirusTotal integration](https://docs.chocolatey.org/en-us/features/virus-check#virustotal).

Normally, the Community Repository's Package Scanner service would upload the installer binary to VirusTotal, as a prerequisite to the moderation process's Scan Testing step. Unfortunately, the package is currently incompatible with it (due to a conflicting OS requirement), and will therefore fail to submit the installer binary.

As new Messenger releases are unlikely to have been scanned prior to an updated package's publication, this would avoid burdening users with [a run-time prompt to optionally upload the installer binary to VirusTotal for scanning](https://docs.chocolatey.org/en-us/features/virus-check#what-if-virustotal-doesnt-have-results-for-a-binary).

### Execution and Testing

Once everything is set up, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available for the last stream that was built. This will also build a new package version using the modified files.

To limit the scope of update checks to a specific update channel, pass the `-IncludeStream` parameter with the desired Stream name:

```powershell
.\update.ps1 -IncludeStream 'Stable'
```

```powershell
.\update.ps1 -IncludeStream 'Beta'
```

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) with a 64-bit Windows 10 v1903+ environment similar to the [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
