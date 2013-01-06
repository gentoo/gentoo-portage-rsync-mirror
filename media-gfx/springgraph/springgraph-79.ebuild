# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/springgraph/springgraph-79.ebuild,v 1.8 2004/07/19 01:54:10 robbat2 Exp $

DESCRIPTION="Generate spring graphs from graphviz input files"
BASE_URI="http://www.chaosreigns.com/code/springgraph"
HOMEPAGE="${BASE_URI}"
SRC_FILENAME="${PN}.pl.${PV}"
SRC_URI="${BASE_URI}/dl/${SRC_FILENAME}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha hppa ~mips ppc sparc ia64 amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-perl/GD"

src_unpack() {
	# nothing to do
	:
}

src_compile() {
	# nothing to do
	:
}

src_install() {
	into /usr
	newbin ${DISTDIR}/${SRC_FILENAME} ${PN}
}
