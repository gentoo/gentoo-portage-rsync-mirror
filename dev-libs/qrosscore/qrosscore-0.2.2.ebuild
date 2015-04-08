# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qrosscore/qrosscore-0.2.2.ebuild,v 1.7 2013/12/27 15:06:51 maksbotan Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="KDE-free version of Kross (core libraries and Qt Script backend)"
HOMEPAGE="http://github.com/0xd34df00d/Qross"
SRC_URI="mirror://github/0xd34df00d/Qross/qross-${PV}.tar.bz2"
S="${WORKDIR}/qross-${PV}/src/qross"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/designer:4
		dev-qt/qtscript:4"
RDEPEND="${DEPEND}"
