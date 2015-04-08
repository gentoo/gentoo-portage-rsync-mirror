#!/usr/bin/env sh
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer2/files/generate-tarball.sh,v 1.1 2012/09/03 16:33:53 scarabeus Exp $

# Orginal author: Nikoli <nikoli@lavabit.com>

PN="mplayer2"

TMPDIR=$(mktemp -d)

echo "Creating git clone in \"${TMPDIR}\""
pushd ${TMPDIR} > /dev/null

# src_unpack
git clone git://git.mplayer2.org/mplayer2.git "${PN}" || exit 1
pushd "${PN}" > /dev/null
	P="${PN}-2.0_p$(git log -n1 --date=short --format=%cd|tr -d '-')"

	# Set snapshot version manually
	echo "$(git describe --match "v[0-9]*" --always)" \
		> snapshot_version || exit 1
	find . -name .git\* -exec rm -rf {} \;
popd > /dev/null

mv "${PN}" "${P}" || exit 1
tar --owner root --group root -cJpf "${P}.tar.xz" "${P}" || exit 1

popd > /dev/null

mv "${TMPDIR}/${P}.tar.xz" . || exit 1
echo "Tarball created: \"${P}.tar.xz\""

rm -rf "${TMPDIR}"
