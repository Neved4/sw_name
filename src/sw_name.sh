#!/bin/sh
set -Cefu

readonly sw_vers='/usr/bin/sw_vers'
readonly app='/System/Library/CoreServices/Setup Assistant.app'
readonly license="$app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf"
reset='\033[0m' red='\033[31m'

errlic() {
	printf '%b\n' \
		"${red}error${reset}: could not find file: OSXSoftwareLicense.rtf" \
		"Version $ver is not supported."
	exit 1
} 2>/dev/stderr

sw_name() {
	awk '$0 ~ /SOFTWARE LICENSE AGREEMENT FOR/ {
		gsub(/.*(macOS|OS X) |\\|.*$0 /, "")
		for(i=1; i<= NF; i++) {
			$i = toupper(substr($i, 1, 1)) tolower(substr($i, 2))
		}
		print
	}' "$license"
}

format() {
	column -t |
	awk '{ gsub(/:  /, ": ") }
		NR==1 { line=$0; next }
		NR==2 { print; print line; next } 1'
}

main() {
	[ ! -f "$license" ] && ver=$($sw_vers -v) && errlic

 	[ $# -eq 0 ] && {
		printf 'ReleaseName:\t%s\n' "$(sw_name)"
		$sw_vers && return 0
	} | format

	for i in "$@"
	do
		case $i in
		-R|-releaseName|--releaseName)
			printf '%s\n' "$(sw_name)" ;;
		*)
			$sw_vers "$i"
		esac
	done
}

main "$@"
