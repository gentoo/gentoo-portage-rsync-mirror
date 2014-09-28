# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qt-meta/qt-meta-4.8.5.ebuild,v 1.4 2014/09/28 22:54:38 pesa Exp $

EAPI=5

DESCRIPTION="Cross-platform application development framework (meta package)"
HOMEPAGE="https://www.qt.io/ https://qt-project.org/"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="4"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="+dbus examples kde openvg +qt3support +webkit"

DEPEND=""
RDEPEND="
	>=dev-qt/assistant-${PV}:4
	>=dev-qt/designer-${PV}:4
	>=dev-qt/linguist-${PV}:4
	>=dev-qt/pixeltool-${PV}:4
	dbus? ( >=dev-qt/qdbusviewer-${PV}:4 )
	qt3support? ( >=dev-qt/qt3support-${PV}:4 )
	>=dev-qt/qtbearer-${PV}:4
	>=dev-qt/qtcore-${PV}:4
	dbus? ( >=dev-qt/qtdbus-${PV}:4 )
	>=dev-qt/qtdeclarative-${PV}:4
	examples? ( >=dev-qt/qtdemo-${PV}:4 )
	>=dev-qt/qtgui-${PV}:4
	>=dev-qt/qthelp-${PV}:4
	>=dev-qt/qtmultimedia-${PV}:4
	>=dev-qt/qtopengl-${PV}:4
	openvg? ( >=dev-qt/qtopenvg-${PV}:4 )
	kde? ( media-libs/phonon )
	!kde? ( || ( >=dev-qt/qtphonon-${PV}:4 media-libs/phonon ) )
	>=dev-qt/qtscript-${PV}:4
	>=dev-qt/qtsql-${PV}:4
	>=dev-qt/qtsvg-${PV}:4
	>=dev-qt/qttest-${PV}:4
	webkit? ( >=dev-qt/qtwebkit-${PV}:4 )
	>=dev-qt/qtxmlpatterns-${PV}:4
"
