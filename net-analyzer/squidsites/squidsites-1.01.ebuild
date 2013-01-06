# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/squidsites/squidsites-1.01.ebuild,v 1.7 2008/01/21 14:56:11 armin76 Exp $

inherit toolchain-funcs

IUSE=""
DESCRIPTION="Squidsites is a tool that parses Squid access log file and generates a report of the most visited sites."
HOMEPAGE="http://www.stefanopassiglia.com/misc.htm"
SRC_URI="http://www.stefanopassiglia.com/downloads/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ppc x86"

DEPEND=""
RDEPEND=""
S="${WORKDIR}/src"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Respect CFLAGS
	sed -i -e "s/CCFLAGS=-g -Wall/CCFLAGS=${CFLAGS}/g" Makefile \
		|| die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	cd "${WORKDIR}"
	dobin src/squidsites
	dodoc Authors Bugs ChangeLog GNU-Manifesto.html README
}
