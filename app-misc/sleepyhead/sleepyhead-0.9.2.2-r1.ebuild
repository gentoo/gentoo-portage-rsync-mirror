# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sleepyhead/sleepyhead-0.9.2.2-r1.ebuild,v 1.3 2012/11/12 01:48:06 rich0 Exp $

EAPI=4
inherit eutils qt4-r2
DESCRIPTION="Software used to analyze data from CPAP machines."
HOMEPAGE="https://sourceforge.net/apps/mediawiki/sleepyhead/index.php?title=Main_Page"

# Point to any required sources; these will be automatically downloaded by
# Portage.
SRC_URI="https://github.com/rich0/rich0-sleepyhead/tarball/${PV} -> ${P}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND="virtual/opengl
		x11-libs/libX11
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
		x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/rich0-rich0-sleepyhead-86250b9"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_prepare() {
#	qt4_src_prepare
	cd "{$S}"
	epatch "${FILESDIR}/gitfix.patch"
	epatch "${FILESDIR}/prs1-64fix.patch"
	epatch "${FILESDIR}/prs1-code8fix.patch"
	epatch "${FILESDIR}/common_gui.patch"

	sed -i '1i#define OF(x) x' quazip/ioapi.h quazip/unzip.c quazip/unzip.h \
	   quazip/zip.c quazip/zip.h quazip/zlib.h
	eqmake4 SleepyHeadQT.pro
}

src_install() {
	cd "{$S}"
	dobin SleepyHead || die
	dodoc README || die
	dodoc docs/* || die
}
