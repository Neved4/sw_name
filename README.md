![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

# `sw_name` - print macOS friendly names! 🚀

Drop-in replacement for `sw_vers` that simplifies retrieving friendly names
in macOS (`Ventura`, `Sonoma`). Currently, neither `uname -a`, `sysctl`,
`system_profiler` or `sw_vers` provide this information.

## Highlights

- 🚀 _**Fast**_ - minimal overhead, [`sw_name.sh`](src/sw_name.awk)
  executes in only ~ `13.4 ms` (_cfr._ `5.7 ms` for `sw_vers`).
- 🔒 _**Robust**_ - accurate output through tests, robust regular
  expressions and parsing.
- 📦 **Self-contained** - no dependencies, lighweight, uses POSIX `awk`,
  `sh` (`1163 bytes`, `60 lines`).

## Getting Started

> [!NOTE]
> _This utility is only intended to work in [macOS]._

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

    -productVersionExtra, --productVersionExtra
        Prints info specific to certain releases (e.g: (a)).

    -b, -buildVersion, --buildVersion
        Prints the build version (e.g.: 23B81, 21A559).

Environment:
    DARWIN_LICENSE
        Specifies the path to a custom license file.
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
ReleaseName:     Sonoma
ProductName:     macOS
ProductVersion:  14.1
BuildVersion:    23B74
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

| Versions                                    | Supported |
| :------------------------------------------ | :-------- |
| All from **`OS X 10.9`** to **`macOS 14`**  | Yes ✅    |

## Acknowledgments

Thanks to [@risc] for helping test legacy OS X versions.

## License

`sw_name` is licensed under the terms of the [MIT License].

See the [LICENSE](LICENSE) file for details.

[macOS]: https://www.apple.com/macos/
[@risc]: https://github.com/0risc
[MIT License]: https://opensource.org/license/mit/
