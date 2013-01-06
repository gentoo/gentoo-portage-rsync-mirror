# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-1.18-r1.ebuild,v 1.2 2011/11/26 18:51:28 jer Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* hppa"
IUSE=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-remove-HOME-TERM.patch \
		"${FILESDIR}"/${PN}-1.16_p1-build.patch \
		"${FILESDIR}"/${P}-include.patch
	sed -i lib/common.h -e '/^#define PALOVERSION/{s|".*"|"'${PV}'"|g}' || die
	sed -i palo/Makefile -e '/^LDFLAGS=/d' || die
}

src_compile() {
	tc-export CC
	emake -C palo || die "make palo failed"
	emake -C ipl || die "make ipl failed"
	emake MACHINE=parisc iplboot || die "make iplboot failed"
}

src_install() {
	into /
	dosbin palo/palo || die

	doman palo.8
	dohtml README.html
	dodoc README palo.conf

	insinto /etc
	doins "${FILESDIR}"/palo.conf || die

	insinto /usr/share/palo
	doins iplboot || die
}
