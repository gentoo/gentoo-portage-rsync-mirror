# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-chewing/ibus-chewing-1.4.3-r1.ebuild,v 1.1 2013/12/30 08:17:38 naota Exp $

EAPI=4
inherit cmake-utils

MY_P=${P}-Source

DESCRIPTION="The Chewing IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="x11-libs/libXtst
	>=app-i18n/ibus-1.3
	>=dev-libs/libchewing-0.3.3
	x11-libs/gtk+:2
	dev-util/gob:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

CMAKE_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}"/${PN}-1.3.10-cflags.patch
	"${FILESDIR}"/${P}-content-type.patch
	)

DOCS="AUTHORS ChangeLog ChangeLog.prev README RELEASE-NOTES.txt USER-GUIDE"

src_configure() {
	local mycmakeargs=(
		-DPRJ_DOC_DIR=/usr/share/doc/${PF}
		)

	cmake-utils_src_configure
}
