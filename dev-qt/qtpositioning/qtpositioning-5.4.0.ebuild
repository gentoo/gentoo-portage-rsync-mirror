# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtpositioning/qtpositioning-5.4.0.ebuild,v 1.1 2014/12/12 14:30:04 kensington Exp $

EAPI=5

QT5_MODULE="qtlocation"

inherit qt5-build

DESCRIPTION="Physical position determination library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

# TODO: src/plugins/position/gypsy
IUSE="geoclue qml"

RDEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	geoclue? (
		app-misc/geoclue:0
		dev-libs/glib:2
	)
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )
"
DEPEND="${RDEPEND}"

QT5_TARGET_SUBDIRS=(
	src/positioning
	src/plugins/position/positionpoll
)

pkg_setup() {
	use geoclue && QT5_TARGET_SUBDIRS+=(src/plugins/position/geoclue)
	use qml && QT5_TARGET_SUBDIRS+=(src/imports/positioning)
}
