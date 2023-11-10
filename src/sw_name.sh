#!/bin/sh
set -Cefu

readonly app='/System/Library/CoreServices/Setup Assistant.app'
readonly license="$app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf"
reset='\033[0m' red='\033[31m'

check_license() {
	if [ ! -f "$license" ]
	then
	 	ver=$(sw_vers -v)
		printf '%b\n' \
			"${red}error${reset}: could not find file: OSXSoftwareLicense.rtf" \
			"Version $ver is not supported."
			exit 1
	fi
}

sw_name() {
	awk '$0 ~ /SOFTWARE LICENSE AGREEMENT FOR/ {
		gsub(/.*(macOS|OS X) |\\|.*$0 /, "")
		for(i=1; i<= NF; i++) {
			$i = toupper(substr($i, 1, 1)) tolower(substr($i, 2))
		}
		print
	}' "$license"
}

sw_vers_name() {
 	if [ $# -eq 0 ]
	then
		printf 'ReleaseName:\t\t%s\n' "$(sw_name)"
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

check_license
sw_vers_name "$@" | column -t |
	awk '{ gsub(/:  /, ": ") }
		NR==1 { line=$0; next }
		NR==2 { print; print line; next } 1'
