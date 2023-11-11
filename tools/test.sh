#!/bin/sh
set -Cefu

main() {
	licenses=$(find -Es tools/samples -type f -regex '.*\.(rtf|html)')
	IFS='
	'

	printf '%s\n' 'Parsed files:'

	for file in $licenses
	do
		ext=${file##*.} path=${file##*/} name=${path% *}

		printf '%-14s%-5s%s' "- $name" "$ext" \
			"$(DARWIN_LICENSE=$file src/sw_name.sh |
				awk '/ReleaseName/ {print $2, $3}')"
		printf '\n'
	done
}

main
