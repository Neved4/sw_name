#!/bin/sh
set -Cefu

sw_name() {
	readonly app='/System/Library/CoreServices/Setup Assistant.app'
	readonly license="$app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf"

	awk '/SOFTWARE LICENSE AGREEMENT FOR/ {
		gsub(/.*(macOS|OS X) |\\|.*SOFTWARE LICENSE AGREEMENT FOR /, "")
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

sw_vers_name "$@"
