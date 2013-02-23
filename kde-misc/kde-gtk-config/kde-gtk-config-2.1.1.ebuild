# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kde-gtk-config/kde-gtk-config-2.1.1.ebuild,v 1.9 2013/02/23 17:24:56 ago Exp $

EAPI=4

KDE_LINGUAS="ca cs da de el es et eu fr ga gl hu id it ja km lt nds nl pl pt
pt_BR ru sv uk zh_CN"
inherit kde4-base

DESCRIPTION="KDE systemsettings kcm to set GTK application look&feel"
HOMEPAGE="http://projects.kde.org/kde-gtk-config"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd"
SLOT="4"
IUSE="debug"

CDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/gtk+:3
"
DEPEND="
	${CDEPEND}
	dev-util/automoc
"
RDEPEND="
	${CDEPEND}
	!kde-misc/kcm_gtk
	$(add_kdebase_dep kcmshell)
"

pkg_postinst() {
	kde4-base_pkg_postinst
	einfo
	elog "If you notice missing icons in your GTK applications, you may have to install"
	elog "the corresponding themes for GTK. A good guess would be x11-themes/oxygen-gtk"
	elog "for example."
	einfo
}
