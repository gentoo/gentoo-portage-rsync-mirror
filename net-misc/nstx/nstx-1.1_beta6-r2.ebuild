# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nstx/nstx-1.1_beta6-r2.ebuild,v 1.6 2010/10/28 10:28:52 ssuominen Exp $

inherit versionator toolchain-funcs eutils

MY_PV=$(replace_version_separator 2 - "${PV}")
MY_P="${PN}-${MY_PV}"
DEBIAN_PV="4"
DEBIAN_A="${PN}_${MY_PV}-${DEBIAN_PV}.diff.gz"

DESCRIPTION="IP over DNS tunnel"
SRC_URI="http://dereference.de/nstx/${MY_P}.tgz
		mirror://debian/pool/main/${PN:0:1}/${PN}/${DEBIAN_A}"
HOMEPAGE="http://dereference.de/nstx/"
RDEPEND=""
DEPEND="virtual/os-headers
		${RDEPEND}"
KEYWORDS="~amd64 x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tgz
	epatch "${DISTDIR}"/${DEBIAN_A}
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	into /usr
	dosbin nstxcd nstxd
	dodoc README Changelog
	doman *.8
}

pkg_postinst() {
	einfo "Please read the documentation provided in"
	einfo "  `find /usr/share/doc/${PF}/ -name 'README*'`"
}
