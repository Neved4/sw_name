#!/bin/sh
set -Cefu

reset='\033[0m'
 blue='\033[34m'

iter() {
	for file in $files
	do
		 ext=${file##*.}
		path=${file##*/}
		path=${path%.*}
		name=${path% *}
		 ver=${path##* }

		printf '%s %5s %-6s%-2s %b%-2s%b\n' "-" "$name" "$ver" "=>" "$blue" \
    		"$(DARWIN_LICENSE=$file src/sw_name.sh -releaseName)" "$reset"
	done
}

main() {
	IFS='
	'

	dir='tools/samples/OSXSoftwareLicense'
	printf 'html:\n'
	files=$(find -Es $dir -type f -regex '.*\.(html)' | sort -V)
	iter
	printf '\n'
	printf 'rtf:\n'
	files=$(find -Es $dir -type f -regex '.*\.(rtf)' | sort -V)
	iter
}

main
