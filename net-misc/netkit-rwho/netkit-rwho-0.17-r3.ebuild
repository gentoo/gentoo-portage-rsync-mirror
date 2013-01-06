# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rwho/netkit-rwho-0.17-r3.ebuild,v 1.3 2010/10/18 13:39:05 leio Exp $

inherit eutils

DESCRIPTION="Netkit - ruptime/rwho/rwhod"
HOMEPAGE="http://www.hcs.harvard.edu/~dholland/computers/netkit.html"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz
	mirror://gentoo/${PN}-0.17-patches.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ~mips ppc s390 sh sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P}-tiny-packet-dos.patch
	epatch "${WORKDIR}"/${P}-gentoo.diff
	epatch "${WORKDIR}"/${P}-debian.patch
}

src_compile() {
	./configure || die "configure failed"
	sed -i \
		-e "s:-O2::" \
		-e "s:-Wpointer-arith::" \
		MCONFIG
	emake || die "emake failed"
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
