# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kchmviewer/kchmviewer-6.0.ebuild,v 1.6 2013/03/02 19:43:26 hwoarang Exp $

EAPI=3
KDE_REQUIRED="never"
inherit fdo-mime qt4-r2 kde4-base eutils

DESCRIPTION="KchmViewer is a feature rich chm file viewer, based on Qt."
HOMEPAGE="http://www.kchmviewer.net/"
SRC_URI="mirror://sourceforge/kchmviewer/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="kde"

RDEPEND="
	dev-libs/chmlib
	>=dev-qt/qtdbus-4.5:4
	>=dev-qt/qtwebkit-4.5:4
	!kde? ( >=dev-qt/qtgui-4.5:4 )
	kde? (
		$(add_kdebase_dep kdelibs)
		!kde-base/okular[chm]
	)
"
DEPEND="${RDEPEND}"

pkg_setup() {
	use kde && kde4-base_pkg_setup
}

src_prepare() {
	base_src_prepare
	sed -e "s:KDE4_SERVICES_INSTALL_DIR:SERVICES_INSTALL_DIR:" \
			-i lib/kio-msits/CMakeLists.txt
	sed -e "s:KDE4_ICON_INSTALL_DIR:ICON_INSTALL_DIR:" \
		-e "s:KDE4_XDG_APPS_INSTALL_DIR:XDG_APPS_INSTALL_DIR:" \
			-i packages/CMakeLists.txt
	sed -e "s:KDE4_BIN_INSTALL_DIR:BIN_INSTALL_DIR:" \
			-i src/CMakeLists.txt
	echo "CONFIG += ordered" >> kchmviewer.pro # parallel build fix #281954
}

src_configure() {
	if use kde; then
		kde4-base_src_configure
	else
		eqmake4
	fi
}

src_compile() {
	if use kde; then
		kde4-base_src_compile
	else
		emake || die
	fi
}

src_test() {
	einfo "No tests exist."
}

src_install() {
	if use kde; then
		kde4-base_src_install
	else
		dobin bin/kchmviewer || die "dobin kchmviewer failed"
		domenu packages/kchmviewer.desktop || die
		dodoc ChangeLog README || die
	fi
	doicon packages/kchmviewer.png || die
	dodoc DBUS-bindings FAQ || die
}

pkg_postinst() {
	use kde && kde4-base_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	use kde && kde4-base_pkg_postrm
	fdo-mime_desktop_database_update
}
