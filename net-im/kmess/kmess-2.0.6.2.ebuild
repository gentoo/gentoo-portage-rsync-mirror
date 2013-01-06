# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-2.0.6.2.ebuild,v 1.4 2012/08/31 13:07:32 johu Exp $

EAPI=4

KDE_LINGUAS="ar ca de el es et fi fr gl hu it ja nl pt_BR ru sk tr zh_CN zh_TW"
inherit kde4-base

MY_P="${P/_/}"

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux"
HOMEPAGE="http://www.kmess.org"
SRC_URI="mirror://sourceforge/${PN}/Latest%20versions/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="4"
IUSE="debug gif konqueror libnotify xscreensaver"
RESTRICT="test"

COMMONDEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl:2
	dev-libs/libxml2
	dev-libs/libxslt
	gif? ( media-libs/giflib )
	konqueror? ( $(add_kdebase_dep libkonq) )
	libnotify? ( $(add_kdebase_dep knotify) )
	xscreensaver? ( x11-libs/libXScrnSaver )
"
DEPEND="${COMMONDEPEND}
	app-text/docbook-xml-dtd:4.2
	xscreensaver? ( x11-proto/scrnsaverproto )
"
RDEPEND="${COMMONDEPEND}
	konqueror? ( $(add_kdebase_dep konqueror) )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e 's:Terminal=0:Terminal=false:' \
		-i data/kmess.desktop || die "fixing .desktop file failed"
	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with gif GIF)
		$(cmake-utils_use_with konqueror LibKonq)
		$(cmake-utils_use_want xscreensaver XSCREENSAVER)"

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "KMess can use the following optional packages:"
	elog "- www-plugins/adobe-flash 	provides support for winks"
	echo
}
