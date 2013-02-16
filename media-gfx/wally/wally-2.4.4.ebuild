# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wally/wally-2.4.4.ebuild,v 1.4 2013/02/16 07:39:56 pacho Exp $

EAPI=4
KDE_REQUIRED="optional"

inherit eutils kde4-base readme.gentoo

DESCRIPTION="A Qt4/KDE4 wallpaper changer"
HOMEPAGE="http://www.becrux.com/index.php?page=projects&name=wally"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug kde"

DEPEND="
	media-libs/libexif
	x11-libs/libX11
	x11-libs/qt-core:4
	x11-libs/qt-dbus:4
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	x11-libs/qt-svg:4
	kde? ( $(add_kdebase_dep kdelibs) )
"
RDEPEND="${DEPEND}"

DOCS=(
	"AUTHORS" "ChangeLog" "README" "README.XFCE4"
	"README.shortcuts" "TODO"
)
PATCHES=(
	"${FILESDIR}/${P}-gold.patch"
	"${FILESDIR}/${PN}-2.2.0-disable_popup.patch"
)

src_prepare() {
	DOC_CONTENTS="In order to use wallyplugin you need to
		restart plasma in your KDE4 enviroment."
	kde4-base_src_prepare
	use kde || epatch "${FILESDIR}/${PN}-2.2.0-disable-kde4.patch"
}

src_configure() {
	mycmakeargs=(
		-DSTATIC=FALSE
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newicon "${S}"/res/images/idle.png wally.png
	make_desktop_entry wally Wally wally "Graphics;Qt"
	use kde && readme.gentoo_create_doc
}

pkg_postinst() {
	use kde && readme.gentoo_print_elog
}
