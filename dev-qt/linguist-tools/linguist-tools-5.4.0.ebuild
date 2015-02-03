# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/linguist-tools/linguist-tools-5.4.0.ebuild,v 1.3 2015/02/03 12:03:49 jer Exp $

EAPI=5

QT5_MODULE="qttools"

inherit qt5-build

DESCRIPTION="Tools for working with Qt translation data files"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE="qml"

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtxml-${PV}:5[debug=]
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/linguist
)

src_prepare() {
	sed -i -e '/SUBDIRS += linguist/d' \
		src/linguist/linguist.pro || die

	qt_use_disable_mod qml qmldevtools-private \
		src/linguist/lupdate/lupdate.pro

	qt5-build_src_prepare
}
