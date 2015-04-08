# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-routed/netkit-routed-0.17-r4.ebuild,v 1.6 2012/07/12 15:55:28 axs Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Netkit - routed"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://debian/pool/main/n/netkit-routed/${PN}_${PV}.orig.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~mips ppc sparc x86"
IUSE=""

src_prepare() {
	sed -i configure -e '/^LDFLAGS=/d' || die sed configure
	epatch "${FILESDIR}"/${P}-time.patch
}

src_configure() {
	# Not an autotools generated configure script
	./configure --with-c-compiler=$(tc-getCC) || die
}

src_install() {
	# ripquery
	dosbin ripquery/ripquery || die
	doman ripquery/ripquery.8

	# routed
	dosbin routed/routed || die
	dosym routed /usr/sbin/in.routed
	doman routed/routed.8
	dosym routed.8 /usr/share/man/man8/in.routed.8

	# docs
	dodoc README ChangeLog
	newdoc routed/README README.routed

	# init scripts
	newconfd "${FILESDIR}"/routed.confd routed
	newinitd "${FILESDIR}"/routed.initd routed
}
