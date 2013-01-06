# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/xprobe/xprobe-0.3.ebuild,v 1.6 2008/05/03 12:04:37 drac Exp $

inherit eutils

MY_P=${PN}2-${PV}

DESCRIPTION="Active OS fingerprinting tool - this is Xprobe2"
HOMEPAGE="http://sys-security.com/blog/xprobe2"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="net-libs/libpcap"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i -e 's:strip:true:' src/Makefile.in || die "sed failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS CHANGELOG CREDITS README TODO docs/*.{txt,pdf}
}
