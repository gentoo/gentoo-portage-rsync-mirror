# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openclipart/openclipart-0.19.ebuild,v 1.4 2009/07/19 13:27:23 nixnut Exp $

EAPI="2"

DESCRIPTION="Open Clip Art Library (openclipart.org)"
HOMEPAGE="http://www.openclipart.org/"

SRC_URI="http://download.openclipart.org/downloads/${PV}/${P}.tar.bz2"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="svg png gzip"

# We don't really need anything to run
DEPEND=""
RDEPEND=""

# suggested basedir for cliparts
CLIPART="/usr/share/clipart/${PN}"

src_compile() {
	local removeext

	if ! use svg && ! use png; then
		elog "No image formats specified - defaulting to all (png and svg)"
	else
		! use png && removeext="${removeext} png"
		! use svg && removeext="${removeext} svg"
	fi

	for ext in ${removeext}; do
		elog "Removing ${ext} files..."
		find -name "*.${ext}" -exec rm -f {} \; \
			|| die "Failed - remove"
	done

	if use gzip; then
		einfo "Compressing SVG files..."
		find -name "*.svg" -print0 | xargs -L 1 -0 \
			bash -c 'gzip -9c "${1}" > "${1}z"; rm -f "${1}"' --
	fi
}

src_install() {
	insinto ${CLIPART}
	doins -r .
}
