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

		printf "%-7s%-12s%-2s $blue%-2s$reset" "- $ext" "$name" "=>" \
			"$(DARWIN_LICENSE=$file src/sw_name.sh -releaseName)"
		printf '\n'
	done
}

main
