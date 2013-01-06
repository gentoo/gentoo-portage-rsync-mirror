# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cpulimit/cpulimit-1.1.ebuild,v 1.7 2009/09/14 21:02:40 volkmar Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Limits the CPU usage of a process"
HOMEPAGE="http://cpulimit.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin cpulimit
	doman "${FILESDIR}/cpulimit.8"
}
