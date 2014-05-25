# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/libqtxdg/libqtxdg-0.5.3.ebuild,v 1.1 2014/05/25 10:30:54 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+qt4 qt5 test"
REQUIRED_USE="^^ ( qt4 qt5 )"

CDEPEND="
	sys-apps/file
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qttools:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
		dev-qt/linguist-tools:5
	)"
DEPEND="${CDEPEND}
	test? (
		qt4? ( dev-qt/qttest:4 )
		qt5? ( dev-qt/qttest:5 )
	)"
RDEPEND="${CDEPEND}
	x11-misc/xdg-utils"

S=${WORKDIR}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use qt5 QT5)
		$(cmake-utils_use test BUILD_TESTS)
	)
	cmake-utils_src_configure
}
