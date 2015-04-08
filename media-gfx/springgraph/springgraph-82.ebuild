# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/springgraph/springgraph-82.ebuild,v 1.10 2005/05/09 00:31:07 agriffis Exp $

inherit eutils

DESCRIPTION="Generate spring graphs from graphviz input files"
HOMEPAGE="http://www.chaosreigns.com/code/springgraph"
MY_PV="0.${PV}"
MY_P="${PN}_${MY_PV}"
SRC_FILE="${MY_P}.orig.tar.gz"
SRC_DEBIAN_PATCH="${MY_P}-1.diff.gz"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${SRC_FILE}
		 mirror://debian/pool/main/${PN:0:1}/${PN}/${SRC_DEBIAN_PATCH}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""
DEPEND=""
RDEPEND="dev-perl/GD"
S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${SRC_FILE}
	epatch ${DISTDIR}/${SRC_DEBIAN_PATCH}
}

src_compile() {
	# nothing to do
	:
}

src_install() {
	into /usr
	dobin ${PN}
	doman debian/${PN}.1
}
