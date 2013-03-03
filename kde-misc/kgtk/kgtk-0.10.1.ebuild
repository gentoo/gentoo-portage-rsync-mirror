# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.10.1.ebuild,v 1.10 2013/03/02 21:30:12 hwoarang Exp $

EAPI=4
KDE_LINGUAS="cs de en_GB es fr pt_BR ru zh_CN"
KDE_LINGUAS_DIR="kdialogd4/po"
inherit kde4-base

DESCRIPTION="Allows *some* Gtk and Qt4 applications to use KDE's file dialogs when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=36077"
SRC_URI="http://home.freeuk.com/cpdrummond/KGtk-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug"

DEPEND="
	x11-libs/gtk+:2
	dev-qt/qtgui:4
	$(add_kdebase_dep kdebase-startkde)
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-glibc-2.10.patch" )

S=${WORKDIR}/KGtk-${PV}

DOCS=( AUTHORS ChangeLog README TODO )

src_configure() {
	local mycmakeargs+=(
		-DKGTK_KDE4=true -DKGTK_QT4=true -DKGTK_GTK2=true
	)
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
	elog "To see the kde-file-selector in a gtk-application, just do:"
	elog "cd /usr/local/bin"
	elog "ln -s /usr/bin/kgtk-wrapper application(eg. firefox)"
	elog "Make sure that /usr/local/bin is before /usr/bin in your \$PATH"
	elog
	elog "You need to restart kde and be sure to change your symlinks to non-.sh"
}
