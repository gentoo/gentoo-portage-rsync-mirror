# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qt-meta/qt-meta-4.8.ebuild,v 1.2 2013/04/08 15:07:15 pesa Exp $

EAPI=2

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="http://qt-project.org/ http://qt.nokia.com/"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="4"
KEYWORDS="amd64 ~arm ~ia64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="dbus kde opengl openvg qt3support"

DEPEND=""
RDEPEND="
	>=dev-qt/qthelp-${PV}:4
	>=dev-qt/qtcore-${PV}:4
	dbus? ( >=dev-qt/qtdbus-${PV}:4 )
	>=dev-qt/qtdeclarative-${PV}:4
	>=dev-qt/qtgui-${PV}:4
	>=dev-qt/qtmultimedia-${PV}:4
	opengl? ( >=dev-qt/qtopengl-${PV}:4 )
	openvg? ( >=dev-qt/qtopenvg-${PV}:4 )
	kde? ( media-libs/phonon )
	!kde? ( || ( >=dev-qt/qtphonon-${PV}:4 media-libs/phonon ) )
	qt3support? ( >=dev-qt/qt3support-${PV}:4 )
	>=dev-qt/qtscript-${PV}:4
	>=dev-qt/qtsql-${PV}:4
	>=dev-qt/qtsvg-${PV}:4
	>=dev-qt/qttest-${PV}:4
	>=dev-qt/qtwebkit-${PV}:4
	>=dev-qt/qtxmlpatterns-${PV}:4
"

pkg_postinst() {
	echo
	einfo "Please note that this meta package is only provided for convenience."
	einfo "No packages should depend directly on this meta package, but on the"
	einfo "specific split Qt packages needed."
	echo
}
