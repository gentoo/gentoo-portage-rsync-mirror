# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-opensteamworks/pidgin-opensteamworks-1.0_p41.ebuild,v 1.2 2013/06/24 05:25:26 ago Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Steam protocol plugin for pidgin"
HOMEPAGE="http://code.google.com/p/pidgin-opensteamworks/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz
	http://pidgin-opensteamworks.googlecode.com/files/icons.zip
	-> ${PN}-icons.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	net-im/pidgin"
DEPEND="${RDEPEND}
	app-arch/unzip
	app-arch/xz-utils
	virtual/pkgconfig"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	# see http://code.google.com/p/pidgin-opensteamworks/issues/detail?id=31
	cp "${FILESDIR}"/${PN}-1.0_p32-Makefile "${S}"/Makefile || die
}

src_install() {
	default
	insinto /usr/share/pixmaps/pidgin/protocols
	doins -r "${WORKDIR}"/{16,48}
}
