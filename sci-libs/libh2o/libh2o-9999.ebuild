# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libh2o/libh2o-9999.ebuild,v 1.2 2013/10/16 13:11:17 mgorny Exp $

EAPI=5

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-r3
#endif

inherit autotools-utils

DESCRIPTION="Library of routines for IF97 water & steam properties"
HOMEPAGE="https://bitbucket.org/mgorny/libh2o/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

DEPEND="virtual/pkgconfig"

#if LIVE
KEYWORDS=
SRC_URI=
#endif

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	autotools-utils_src_configure
}
