# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sw-notify-send/sw-notify-send-9999.ebuild,v 1.1 2012/12/15 12:47:46 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/tinynotify-send.git"

inherit git-2
#endif

inherit autotools-utils

MY_PN=tinynotify-send
MY_P=${MY_PN}-${PV}

DESCRIPTION="A system-wide variant of tinynotify-send"
HOMEPAGE="https://bitbucket.org/mgorny/tinynotify-send/"
SRC_URI="mirror://bitbucket/mgorny/${MY_PN}/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libtinynotify
	~x11-libs/libtinynotify-cli-${PV}
	x11-libs/libtinynotify-systemwide"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

#if LIVE
KEYWORDS=
SRC_URI=
DEPEND="${DEPEND}
	dev-util/gtk-doc"
#endif

src_configure() {
	myeconfargs=(
		--disable-library
		--disable-regular
		--enable-system-wide
	)

	autotools-utils_src_configure
}
