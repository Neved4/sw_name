#!/bin/sh

sw_name() {
	readonly app='/System/Library/CoreServices/Setup Assistant.app'
	readonly license="$app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf"

	awk '/SOFTWARE LICENSE AGREEMENT FOR/ {
		print substr($NF, 1, length($NF)-1)
	}' "$license"
}

print_sw_name() {
	printf 'ReleaseName:\t\t%s\n' "$(sw_name)"
}

sw_vers_name() {
 	if [ $# -eq 0 ]
	then
		print_sw_name
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
