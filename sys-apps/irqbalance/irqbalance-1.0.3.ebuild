# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-1.0.3.ebuild,v 1.5 2012/08/14 10:36:47 johu Exp $

EAPI=4

inherit systemd

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://irqbalance.googlecode.com/"
SRC_URI="http://irqbalance.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="caps numa"

RDEPEND="dev-libs/glib:2
	caps? ( sys-libs/libcap-ng )
	numa? ( sys-process/numactl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_with caps libcap-ng) \
		$(use_enable numa)
}

src_install() {
	default
	newinitd "${FILESDIR}"/irqbalance.init.2 irqbalance
	newconfd "${FILESDIR}"/irqbalance.confd-1 irqbalance
	systemd_dounit "${FILESDIR}"/irqbalance.service
}
