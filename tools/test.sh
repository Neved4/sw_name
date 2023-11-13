#!/bin/sh
set -Cefu

reset='\033[0m'
  red='\033[31m'
green='\033[32m'
 blue='\033[34m'

iter() {
	for file in $files
	do
		 ext=${file##*.}
		path=${file##*/}
		path=${path%.*}
		name=${path% *}
		 ver=${path##* }

		color=$blue
		friendly=$(DARWIN_LICENSE=$file src/sw_name.sh -releaseName)

		for i in '10.9 Mavericks' '10.10 Yosemite' '10.11 El Capitan' \
		    '10.12 Sierra' '10.13 High Sierra' '10.14 Mojave' '10.15 Catalina' \
			'11 Big Sur' '12 Monterey' '13 Ventura' '14 Sonoma'
		do
			i_ver=${i%% *} i_friendly=${i#* }

			if [ "$ver" = "$i_ver" ]
			then
				[ "$friendly" = "$i_friendly" ] && color=$green || color=$red
			fi
		done

		printf '%s %5s %-6s%-2s %b%-2s%b\n' "-" "$name" "$ver" "=>" "$color" \
    		"$friendly" "$reset"
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
