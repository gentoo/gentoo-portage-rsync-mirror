# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmess/kmess-9999.ebuild,v 1.6 2014/07/25 21:49:50 johu Exp $

EAPI=5

EGIT_HAS_SUBMODULES="true"
KDE_LINGUAS="ar ca da de el es et fi fr hu it ko nb nl pt_BR sk sl sv th tr zh_CN zh_TW"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git
	http://git.gitorious.org/${PN}/${PN}.git"

inherit git-2 kde4-base

DESCRIPTION="KMess is an alternative MSN Messenger chat client for Linux"
HOMEPAGE="http://www.kmess.org"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="4"
IUSE="debug gif konqueror libnotify xscreensaver"

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
	xscreensaver? ( x11-proto/scrnsaverproto )
"
RDEPEND="${COMMONDEPEND}
	!net-im/kmess:0
	konqueror? ( $(add_kdebase_dep konqueror) )
"
RESTRICT="test"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with gif)
		$(cmake-utils_use_with konqueror LibKonq)
		$(cmake-utils_use_want xscreensaver)
	)

	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst

	echo
	elog "KMess can use the following optional packages:"
	elog "- www-plugins/adobe-flash		provides support for winks"
	echo
}
