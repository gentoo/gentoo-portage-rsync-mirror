#!/bin/bash
# PaX marking code stolen from pax-utils.eclass

flags=${1//-}; shift

if type -p paxctl > /dev/null; then
	echo "PT PaX marking -${flags} $@"
	for f in "$@"; do
		# First, try modifying the existing PAX_FLAGS header
		paxctl -q${flags} "${f}" && continue
		# Second, try stealing the (unused under PaX) PT_GNU_STACK header
		paxctl -qc${flags} "${f}" && continue
		# Third, try pulling the base down a page, to create space and
		# insert a PT_GNU_STACK header (works on ET_EXEC)
		paxctl -qC${flags} "${f}" && continue
	done
elif type -p scanelf > /dev/null; then
	# Try scanelf, the Gentoo swiss-army knife ELF utility
	# Currently this sets PT if it can, no option to control what it does.
	echo "Fallback PaX marking -${flags} $@"
	scanelf -Xxz ${flags} "$@"
fi

exit 0
