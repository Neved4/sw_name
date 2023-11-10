#!/bin/sh
set -Cefu

main() {
	licenses=$(find tools/samples -name "*.rtf" -type f)
	IFS='
	'

	for lic in $licenses
	do
		lic_name=${lic##*/} lic_name=${lic_name% *}

		printf '%s %-12s%s%s' "Parsing" "$lic_name" "ReleaseName... " \
			"$(DARWIN_LICENSE=$lic src/sw_name.sh |
				awk '/ReleaseName/ {print $2, $3}')"
		printf '\n'
	done
}

main
