# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-messenger@11eade7e5c9cf02a523fc1a90c744a146ba806b7/messenger.png" width="48" height="48"/> Chocolatey Package: [Messenger](https://community.chocolatey.org/packages/messenger)

[![Total package download count shield](https://img.shields.io/chocolatey/v/messenger.svg?include_prereleases)](https://community.chocolatey.org/packages/messenger)
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

>**Note**
>The session ID secret will require occasional updates to work around sessions expiring or otherwise being invalidated by Facebook (e.g. logging out, password changes, device removal, suspicious account activity, etc.).

### Execution and Testing

Once everything is set up, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) with a 64-bit Windows 10 v1903+ environment similar to the [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
