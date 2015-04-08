# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libtinynotify-cli/libtinynotify-cli-9999.ebuild,v 1.3 2014/07/06 13:24:03 mgorny Exp $

EAPI=5

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/tinynotify-send.git"

inherit git-r3
#endif

inherit autotools-utils

MY_PN=tinynotify-send
MY_P=${MY_PN}-${PV}

DESCRIPTION="Common CLI routines for tinynotify-send & sw-notify-send"
HOMEPAGE="https://bitbucket.org/mgorny/tinynotify-send/"
SRC_URI="https://www.bitbucket.org/mgorny/${MY_PN}/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="x11-libs/libtinynotify:0="
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

#if LIVE
KEYWORDS=
SRC_URI=
DEPEND="${DEPEND}
	>=dev-util/gtk-doc-1.18"
#endif

src_configure() {
	local myeconfargs=(
		$(use_enable doc gtk-doc)
		--disable-regular
		--disable-system-wide
	)

	autotools-utils_src_configure
}
