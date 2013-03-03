# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sleepyhead/sleepyhead-9999.ebuild,v 1.2 2013/03/02 19:31:33 hwoarang Exp $

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
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-qt/qtwebkit:4"
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
