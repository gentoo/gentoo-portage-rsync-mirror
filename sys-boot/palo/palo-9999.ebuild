# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/palo/palo-9999.ebuild,v 1.4 2013/07/21 14:13:39 jer Exp $

EAPI=5

inherit eutils flag-o-matic git-2 toolchain-funcs

DESCRIPTION="PALO : PArisc Linux Loader"
HOMEPAGE="http://parisc-linux.org/"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/deller/palo.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-9999-toolchain.patch
	sed -i lib/common.h -e '/^#define PALOVERSION/{s|".*"|"'${PV}'"|g}' || die
	sed -i palo/Makefile -e '/^LDFLAGS=/d'  || die
}

src_compile() {
	emake MACHINE=parisc AR=$(tc-getAR) CC=$(tc-getCC) LD=$(tc-getLD) \
		makepalo makeipl || die
	emake MACHINE=parisc CC=$(tc-getCC) iplboot || die
}

src_install() {
	into /
	dosbin palo/palo

	doman palo.8
	dodoc palo.conf
	dohtml README.html

	insinto /etc
	doins "${FILESDIR}"/palo.conf

	insinto /usr/share/palo
	doins iplboot

	insinto /etc/kernel/postinst.d/
	INSOPTIONS="-m 0744" doins "${FILESDIR}"/99palo
}
