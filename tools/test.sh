#!/bin/sh
set -Cefu

reset='\033[0m'
 blue='\033[34m'

findlic() {
	find -Es tools/samples -type f -regex '.*\.(rtf|html)' | sort -V
}

main() {
	licenses=$(findlic)
	IFS='
	'

	printf '%s\n' 'Parsed files:'

	for file in $licenses
	do
		ext=${file##*.} path=${file##*/} name=${path% *}

		printf "%-14s%-5s%-2s $blue%-2s$reset" "- $name" "$ext" "=>" \
			"$(DARWIN_LICENSE=$file src/sw_name.sh |
				awk '/ReleaseName/ {print $2, $3}')"
		printf '\n'
	done
}

main
