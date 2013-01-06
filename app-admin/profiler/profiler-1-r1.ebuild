# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/profiler/profiler-1-r1.ebuild,v 1.8 2012/11/27 23:49:48 sping Exp $

inherit java-pkg-2

DESCRIPTION="Provides 3D visual representation of file system statistics"
HOMEPAGE="https://bugs.gentoo.org/show_bug.cgi?id=288717" # since visualversion.com died
SRC_URI="profiler.jar"
RESTRICT="bindist fetch"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}"/ || die
}

src_compile() {
	:
}

src_install() {
	dobin "${FILESDIR}"/profiler || die
	java-pkg_dojar ${A} || die
}
