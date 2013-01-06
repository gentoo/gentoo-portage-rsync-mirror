# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.16.1.ebuild,v 1.2 2012/08/07 16:02:31 kensington Exp $

EAPI=4
KDE_REQUIRED="optional"
KDE_HANDBOOK="optional"
KDE_LINGUAS="de cs es fr hu it"
inherit kde4-base

DESCRIPTION="IDE for applications based on PIC and dsPIC microcontrollers"
HOMEPAGE="http://piklab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/readline
	virtual/libusb:0
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-qt3support:4"
RDEPEND="${DEPEND}"

DOCS=( Changelog README TODO )

src_prepare() {
	sed -e "/install(FILES README/d" \
		-i CMakeLists.txt || die

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use !kde QT_ONLY)
		-DLOCALE_INSTALL_DIR="/usr/share/locale"
	)
	kde4-base_src_configure
}
