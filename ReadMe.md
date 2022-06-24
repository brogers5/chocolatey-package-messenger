# <img src="https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-messenger@11eade7e5c9cf02a523fc1a90c744a146ba806b7/messenger.png" width="48" height="48"/> Chocolatey Package: [Messenger](https://community.chocolatey.org/packages/messenger/)
[![Chocolatey package version](https://img.shields.io/chocolatey/v/messenger.svg)](https://community.chocolatey.org/packages/messenger/)
[![Chocolatey package download count](https://img.shields.io/chocolatey/dt/messenger.svg)](https://community.chocolatey.org/packages/messenger/)

## Install
[Install Chocolatey](https://chocolatey.org/install), and run the following command to install the latest approved version on the Chocolatey Community Repository:
```shell
choco install messenger
```

Alternatively, the packages as published on the Chocolatey Community Repository will also be mirrored on this repository's [Releases page](https://github.com/brogers5/chocolatey-package-messenger/releases). The `nupkg` can be installed from the current directory as follows:

```shell
choco install messenger -s .
```

## Build
[Install Chocolatey](https://chocolatey.org/install), clone this repository, and run the following command in the cloned repository:
```shell
choco pack
```

A successful build will create `messenger.x.y.z.nupkg`, where `x.y.z` should be the Nuspec's `version` value at build time.

Note that Chocolatey package builds are non-deterministic. Consequently, an independently built package will fail a checksum validation against officially published packages.

## Update
This package should be automatically updated by the [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au). If it is outdated by more than a few days, please [open an issue](https://github.com/brogers5/chocolatey-package-messenger/issues).

AU expects the parent directory that contains this repository to share a name with the Nuspec (`messenger`). Your local repository should therefore be cloned accordingly:
```shell
git clone git@github.com:brogers5/chocolatey-package-messenger.git messenger
```

Alternatively, a junction point can be created that points to the local repository (preferably within a repository adopting the [AU packages template](https://github.com/majkinetor/au-packages-template)):
```shell
mklink /J messenger ..\chocolatey-package-messenger
```

Once created, simply run `update.ps1` from within the created directory/junction point. Assuming all goes well, all relevant files should change to reflect the latest version available. This will also build a new package version using the modified files.

Before submitting a pull request, please [test the package](https://docs.chocolatey.org/en-us/community-repository/moderation/package-verifier#steps-for-each-package) with a 64-bit Windows 10 v1903+ environment similar to the [Chocolatey Testing Environment](https://github.com/chocolatey-community/chocolatey-test-environment) first.
