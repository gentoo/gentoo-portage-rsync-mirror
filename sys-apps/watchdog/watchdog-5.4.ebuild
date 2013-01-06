# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/watchdog-5.4.ebuild,v 1.6 2011/02/12 18:56:15 armin76 Exp $

inherit eutils

DESCRIPTION="A software watchdog"
HOMEPAGE="http://sourceforge.net/projects/watchdog/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm m68k ~mips ppc s390 sh ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-5.2.6-headers.patch
	epatch "${FILESDIR}"/${PN}-5.2.6-uclibc.patch
#	epatch "${WORKDIR}"/${MY_P}-${PATCH_LEVEL}.diff
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}

	dodoc AUTHORS README TODO NEWS ChangeLog
	docinto examples
	dodoc examples/*
}
