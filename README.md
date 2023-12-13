![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

# `sw_name` - print macOS friendly names! 🚀

Drop-in replacement for `sw_vers` that simplifies retrieving friendly names
in macOS (`Ventura`, `Sonoma`).

Currently, neither `uname -a`, `sysctl`, `system_profiler` or `sw_vers`
provide this information.

## Highlights

- 🚀 _**Fast**_ – minimal overhead, [`sw_name -releaseName`] function
  executes in `~ 5.7 ms`, of `~ 27 ms` total.[^1]
- 🔒 _**Robust**_ – accurate output through tests, robust regular
  expressions and tried parsing.
- 📦 _**Lightweight**_ – self-contained, zero dependencies, uses POSIX `awk`,
  `sh` (`1245 bytes`, `65 lines`).

## Getting Started

> [!NOTE]
> _This utility is only intended to work from [OS X](macOS) 10.9 to [macOS]
> 14.0._

### Usage

`sw_name` can be invoked in the following ways:
```sh
sw_name
sw_name -releaseName
sw_name -productName
sw_name -productVersion
sw_name -productVersionExtra
sw_name -buildVersion
```

With the following options and environment:
```
Options:
    -R, -releaseName, --releaseName
        Prints release name (e.g.: Sonoma, Ventura, Monterey).

    -n, -productName, --productName
        Prints product name (e.g.: macOS, Mac OS X).

    -v, -productVersion, --productVersion
        Prints product version (e.g.: 12.1, 14.0).

    -E, -productVersionExtra, --productVersionExtra
        Prints info specific to certain releases (e.g: (a)).

    -b, -buildVersion, --buildVersion
        Prints the build version (e.g.: 23B81, 21A559).

Environment:
    DARWIN_LICENSE
        Specifies the path to a custom license file.

        Example: DARWIN_LICENSE=path/to/license sw_name
```

### Setup

Clone the repository:
```sh
git clone https://github.com/Neved4/sw_vers
```

Add the following to your shell profile (e.g. `.bash_profile`, `.zprofile`,
`.profile`):
```sh
alias sw_vers='/path/to/sw_vers_name.sh'
```

Then simply execute it:
```console
$ sw_vers
ReleaseName:    Sonoma
ProductName:    macOS
ProductVersion: 14.1
BuildVersion:   23B74
```

Then you can use `sw_vers` normally, with a new `-releaseName` flag to
access macOS friendly names.

***

Alternatively, if you prefer a concise function, you can add this to your
shell profile:
```sh
sw_name() {
    awk '/SOFTWARE LICENSE AGREEMENT FOR/ {
        gsub(/.*(macOS|OS X) |\\|.*$0 /, "")
        print
    }' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf'
}
```

And then call the new command:
```console
$ sw_name
Sonoma
```

## Compatibility

### Supported macOS Versions

| Version           | Supported |
| :---------------- | :-------- |
| **`macOS 14`**    | Yes ✅     |
| **`macOS 13`**    | Yes ✅     |
| **`macOS 12`**    | Yes ✅     |
| **`macOS 11`**    | Yes ✅     |
| **`macOS 10.15`** | Yes ✅     |
| **`macOS 10.14`** | Yes ✅     |
| **`macOS 10.13`** | Yes ✅     |
| **`macOS 10.12`** | Yes ✅     |
| **`OS X 10.11`**  | Yes ✅     |
| **`OS X 10.10`**  | Yes ✅     |
| **`OS X 10.9`**   | Yes ✅     |

<details closed>
  <summary><b>Supported shells</b></summary>

`sw_name` uses [macOS]'s `/bin/sh` by default, but you can run it with
other POSIX shells too:
```sh
dash /path/to/sw_name.sh
```

#### Supported shells

|     Shell | Version       | Supported |
| --------: | :------------ | :-------- |
|  [`bash`] | `5.2.15`      | ✅ Yes     |
|  [`dash`] | `0.5.12`      | ✅ Yes     |
| [`ksh93`] | `93u+m/1.0.7` | ✅ Yes     |
|  [`mksh`] | `59c`         | ✅ Yes     |
|  [`oksh`] | `7.3`         | ✅ Yes     |
|   [`osh`] | `0.18.0`      | ✅ Yes     |
|  [`posh`] | `0.14.1`      | ❌ No      |
|  [`yash`] | `2.55`        | ✅ Yes     |
|   [`zsh`] | `5.9`         | ✅ Yes      |

</details>

## Acknowledgments

Thanks to [@0risc] for testing legacy OS X versions.

## License

`sw_name` is licensed under the terms of the [MIT License].

See the [LICENSE](LICENSE) file for details.

[^1]: _cfr._ `4.9 ms` for `sw_vers -productName`, tested with [`hyperfine`].

[`sw_name -releaseName`]: https://github.com/Neved4/sw_name/blob/main/src/sw_name.sh#L21-L29
[`hyperfine`]:https://github.com/sharkdp/hyperfine
[macOS]: https://www.apple.com/macos/
[@0risc]: https://github.com/0risc
[MIT License]: https://opensource.org/license/mit/

[`bash`]: https://git.savannah.gnu.org/cgit/bash.git/
[`dash`]: https://git.kernel.org/pub/scm/utils/dash/dash.git
[`ksh93`]: https://github.com/ksh93/ksh
[`mksh`]: https://github.com/MirBSD/mksh
[`osh`]: https://www.oilshell.org/cross-ref.html?tag=OSH#OSH
[`oksh`]: https://github.com/ibara/oksh
[`posh`]: https://salsa.debian.org/clint/posh
[`yash`]: https://github.com/magicant/yash
[`zsh`]: https://github.com/zsh-users/zsh
