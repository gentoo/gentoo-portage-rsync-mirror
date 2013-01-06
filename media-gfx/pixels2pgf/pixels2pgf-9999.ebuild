# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pixels2pgf/pixels2pgf-9999.ebuild,v 1.1 2012/12/15 12:45:57 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-2
#endif

inherit autotools-utils

DESCRIPTION="Convert pixel images (e.g. QRCode) to PGF/Tikz rectangles"
HOMEPAGE="https://bitbucket.org/mgorny/pixels2pgf/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image"
DEPEND="${RDEPEND}"
#if LIVE

KEYWORDS=
SRC_URI=
#endif
