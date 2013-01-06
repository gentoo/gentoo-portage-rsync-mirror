# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dissembler/dissembler-0.9.ebuild,v 1.3 2008/10/25 21:01:10 vapier Exp $

inherit eutils toolchain-funcs

MY_P=${PN}_${PV}
DESCRIPTION="polymorphs bytecode to a printable ASCII string"
HOMEPAGE="http://www.phiral.com/research/dissembler.html"
SRC_URI="http://www.phiral.com/research/${MY_P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake CC="$(tc-getCC)" ${PN} || die
}

src_install() {
	dobin ${PN} || die
	dodoc ${PN}.txt
}
