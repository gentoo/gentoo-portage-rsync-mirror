# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libkscreen/libkscreen-1.0.ebuild,v 1.1 2013/06/23 10:54:34 johu Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
inherit kde4-base

DESCRIPTION="KDE screen management library"
HOMEPAGE="https://projects.kde.org/projects/playground/libs/libkscreen"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	>=dev-libs/qjson-0.8
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXrandr
"
DEPEND="
	${RDEPEND}
	test? ( dev-qt/qttest:4 )
"

RESTRICT="test"
