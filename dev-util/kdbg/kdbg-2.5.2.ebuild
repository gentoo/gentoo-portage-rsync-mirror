# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-2.5.2.ebuild,v 1.1 2012/08/31 11:24:04 johu Exp $

EAPI=4

KDE_LINGUAS="cs da de es fr hr hu it ja nb nn pl pt ro ru sk sr sv tr zh_CN"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A graphical debugger interface"
HOMEPAGE="http://www.kdbg.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="sys-devel/gdb"
DEPEND="${RDEPEND}"

DOCS=( BUGS README ReleaseNotes-${PV} TODO )

src_prepare() {
	mv kdbg/doc . || die
	sed -i -e '/add_subdirectory(doc)/d' kdbg/CMakeLists.txt || die
	echo "add_subdirectory ( doc ) " >> CMakeLists.txt || die
	kde4-base_src_prepare
}

src_install() {
	kde4-base_src_install
	rm -f "${ED}"usr/share/doc/${PF}/ChangeLog-pre*
}
