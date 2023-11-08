![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

# `sw_name` - print macOS friendly names! 🚀

## Background

`sw_name` is a drop-in replacement for `sw_vers` that simplifies retrieving
friendly names in macOS (`Ventura`, `Sonoma`). Currently, neither `uname -a`
`sysctl` or `sw_vers` provide this information, and `system_profiler` is not
easily parseable and is slower.

## Getting Started

> [!NOTE]
> _This utility is only intended to work in macOS._

### Usage

```sh
sw_name
sw_name --releaseName
sw_name --productName
sw_name --productVersion
sw_name --productVersionExtra
sw_name --buildVersion
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
$ sw_vers | column
ReleaseName:     Sonoma
ProductName:     macOS
ProductVersion:  14.1
BuildVersion:    23B74
```

Then you can use `sw_vers` normally, with a new `-releaseName` flag to
access macOS friendly names.

If you prefer a concise function, just add to your shell profile:
```sh
sw_name() {
    awk '/SOFTWARE LICENSE AGREEMENT FOR macOS/ {
        print substr($NF, 1, length($NF)-1)
    }' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf'
}
```

And then call new command:
```console
$ sw_name
Sonoma
```

## Compatibility

### Supported macOS Versions

| Versions                                     | Supported |
| :------------------------------------------- | :-------- |
| All from **`macOS 10.5`** to **`macOS 14`** | Yes ✅     |

## License

`sw_name` is licensed under the terms of the [MIT License].
   
See the [LICENSE](LICENSE) file for details.

[MIT License]: https://opensource.org/license/mit/
