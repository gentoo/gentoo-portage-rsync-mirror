# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-opensteamworks/pidgin-opensteamworks-1.3.ebuild,v 1.1 2013/09/05 10:10:00 hasufell Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Steam protocol plugin for pidgin"
HOMEPAGE="http://code.google.com/p/pidgin-opensteamworks/"
SRC_URI="http://pidgin-opensteamworks.googlecode.com/files/steam-mobile-${PV}.tar.bz2
	http://pidgin-opensteamworks.googlecode.com/files/icons.zip
	-> ${PN}-icons.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/nss
	gnome-base/libgnome-keyring
	net-im/pidgin"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig"

S=${WORKDIR}

pkg_setup() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		tc-export CC PKG_CONFIG
	fi
}

src_prepare() {
	# see http://code.google.com/p/pidgin-opensteamworks/issues/detail?id=31
	cp "${FILESDIR}"/${P}-Makefile "${S}"/Makefile || die
}

src_install() {
	default
	insinto /usr/share/pixmaps/pidgin/protocols
	doins -r "${WORKDIR}"/{16,48}
}
