#!/bin/sh
set -Cefu

readonly sw_vers='/usr/bin/sw_vers'
readonly setup_app='/System/Library/CoreServices/Setup Assistant.app'
readonly license_dir="$setup_app/Contents/Resources/en.lproj/"
readonly license="${DARWIN_LICENSE:-$license_dir/OSXSoftwareLicense.rtf}"

reset='\033[0m' red='\033[31m'

println() {
	printf '%b\n' "$@"
}

errlic() {
	println "${red}error${reset}: could not find file: $license" \
		"Version $ver is not supported."
	exit 1
} 2>/dev/stderr

sw_name() {
	awk '$0 ~ /SOFTWARE LICENSE AGREEMENT FOR/ {
		gsub(/.*(macOS|OS X) |\\|<\/[^>]+>/, "")
		for(i=1; i<= NF; i++) {
			$i = toupper(substr($i, 1, 1)) tolower(substr($i, 2))
		}
		print
	}' "$license"
}

format() {
	column -t |
	awk 'NR==1 || NR==2 {
		n=split($0, a, / +/)
		$0=a[1] "     " a[2] " " a[3]
		for (i=4; i<=n; i++) {
			$0 = $0 " " a[i]
		}
	}
	{ gsub(/:  /, ": "); }
	NR==1 { line=$0; next; }
	NR==2 { print; print line; next; }
	{ print }'
}

main() {
	[ ! -f "$license" ] && ver=$($sw_vers -productVersion) && errlic

 	[ $# -eq 0 ] && {
		println "ReleaseName:\t$(sw_name)"
		$sw_vers && return 0
	} | format

	for i in "$@"
	do
		case $i in
		-R|-releaseName|--releaseName)
			println "$(sw_name)" ;;
		-n|-productName|--productName)
			$sw_vers -productName ;;
     	-v|-productVersion|--productVersion)
			$sw_vers -productVersion ;;
		-E|-productVersionExtra|--productVersionExtra)
			$sw_vers -productVersionExtra ;;
     	-b|-buildVersion|--buildVersion)
			$sw_vers -buildVersion ;;
		*)
			$sw_vers "$i" ;;
		esac
	done
}

main "$@"
