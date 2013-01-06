# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwho/netkit-rwho-0.17-r4.ebuild,v 1.6 2012/02/06 18:28:19 ranger Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Netkit - ruptime/rwho/rwhod"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz
	mirror://gentoo/${PN}-0.17-patches.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ~mips ppc s390 sh sparc x86"
IUSE=""

src_prepare() {
	epatch "${WORKDIR}"/${P}-tiny-packet-dos.patch
	epatch "${WORKDIR}"/${P}-gentoo.diff
	epatch "${WORKDIR}"/${P}-debian.patch
	sed -i configure \
		-e '/^LDFLAGS=/d' \
		|| die "sed configure"
}

src_configure() {
	# Not an autotools build system
	./configure --with-c-compiler=$(tc-getCC) || die "configure failed"
	sed -i MCONFIG \
		-e "s:-O2::" \
		-e "s:-Wpointer-arith::" \
		|| die "sed MCONFIG"
}

src_install() {
	keepdir /var/spool/rwho

	into /usr
	dobin ruptime/ruptime rwho/rwho || die "dobin failed"
	dosbin rwhod/rwhod || die "dosbin failed"
	doman ruptime/ruptime.1 rwho/rwho.1 rwhod/rwhod.8
	dodoc README ChangeLog

	newinitd "${FILESDIR}"/${P}-rc rwhod
	newconfd "${FILESDIR}"/${P}-confd rwhod

	exeinto /etc/cron.monthly
	doexe "${FILESDIR}"/${P}-cron
}
