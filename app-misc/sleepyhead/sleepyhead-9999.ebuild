# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sleepyhead/sleepyhead-9999.ebuild,v 1.1 2012/11/24 18:11:34 rich0 Exp $

EAPI=4
inherit eutils git-2 qt4-r2
DESCRIPTION="Software used to analyze data from CPAP machines."
HOMEPAGE="https://sourceforge.net/apps/mediawiki/sleepyhead/index.php?title=Main_Page"

# Point to any required sources; these will be automatically downloaded by
# Portage.
EGIT_REPO_URI="git://github.com/rich0/rich0-sleepyhead.git"
EGIT_BRANCH="rich-test"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

IUSE="debug"

DEPEND="virtual/opengl
		x11-libs/libX11
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
		x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

src_unpack() {
git-2_src_unpack
}

src_prepare() {
#	qt4_src_prepare
	cd "{$S}/sleepyhead-9999"
#	sed -i '1i#define OF(x) x' quazip/ioapi.h quazip/unzip.c quazip/unzip.h \
#           quazip/zip.c quazip/zip.h quazip/zlib.h
	eqmake4 SleepyHeadQT.pro
}

src_install() {
	cd "{$S}/sleepyhead-9999"
	dobin SleepyHead || die
	dodoc README || die
	dodoc docs/* || die
}
