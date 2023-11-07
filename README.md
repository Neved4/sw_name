![Shell Script](https://img.shields.io/badge/Shell_Script-9DDE66?logo=gnubash&logoColor=000&style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=fff)

# `sw_name` - print macOS friendly names! 🚀

## Background

`sw_name` is a drop-in replacement for `sw_vers` that simplifies retrieving friendly names in macOS (`Ventura`, `Sonoma`). Currently, both `uname -a` and `sw_vers` won't provide this information, and `system_profiler` is not easily parseable and slower.

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

Add the following to your shell profile (e.g. `.bash_profile`, `.zprofile`, `.profile`):
```sh
alias sw_vers='/path/to/sw_vers_name.sh'
```

Then simply execute it:
```sh
$ sw_vers | column
ReleaseName:     Sonoma
ProductName:     macOS
ProductVersion:  14.1
BuildVersion:    23B74
```

Alternatively you can add it as a function in your profile:
```sh
sw_name() {
    app='/System/Library/CoreServices/Setup Assistant.app'
    license="$app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf"

    awk '/SOFTWARE LICENSE AGREEMENT FOR macOS/ {
        print substr($NF, 1, length($NF)-1)
    }' "$license"
}

print_sw_name() {
    printf 'ReleaseName:\t\t%s\n' "$(sw_name)"
}

sw_vers_name() {
    if [ $# -eq 0 ]
    then
        sw_name
        /usr/bin/sw_vers
        return 0
    fi

    for i in "$@"
    do
        case $i in
        -R|-releaseName|--releaseName)
            printf '%s\n' "$(sw_name)" ;;
        *)
            /usr/bin/sw_vers "$i" ;;
        esac
    done
}
```

And then alias the new command:

```sh
alias sw_vers='sw_vers_name'
```

Then you can use `sw_vers` normally, with a new `-releaseName` flag to access macOS friendly names.

If you prefer a concise function, just use `sw_name()`.

## Compatibility

### Supported macOS Versions

| Version                 | Supported |
| :---------------------- | :-------- |
| **`macOS 14 Sonoma`**   | Yes ✅     |
| **`macOS 13 Ventura`**  | Yes ✅     |
| **`macOS 12 Monterey`** | Yes ✅     |
| **`macOS 11 Big Sur`**  | Yes ✅     |

## License

`tmbackup` is licensed under the terms of the [MIT License].
   
See the [LICENSE](LICENSE) file for details.

[MIT License]: https://opensource.org/license/mit/
