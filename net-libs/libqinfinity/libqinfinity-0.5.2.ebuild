# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libqinfinity/libqinfinity-0.5.2.ebuild,v 1.1 2013/10/29 21:55:25 johu Exp $

EAPI=5

MY_P="${PN}-v${PV}"
inherit cmake-utils

DESCRIPTION="Qt-style interface for libinfinity"
HOMEPAGE="https://projects.kde.org/projects/playground/libs/libqinfinity"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	net-libs/libinfinity
"
DEPEND="${RDEPEND}
	app-arch/xz-utils
"

S=${WORKDIR}/${MY_P}
