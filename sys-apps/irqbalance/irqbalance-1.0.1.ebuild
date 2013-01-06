# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-1.0.1.ebuild,v 1.2 2012/05/04 09:17:28 jdhore Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://irqbalance.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="caps numa"

RDEPEND="dev-libs/glib:2
	caps? ( sys-libs/libcap-ng )
	numa? ( sys-process/numactl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	mv cap-ng.m4 acinclude.m4 || die
	if ! use numa ; then
		echo 'static inline int numa_available(void) { return -1; }' > numa.h
		sed -i 's:-lnuma::' Makefile.am || die
	fi
	eautoreconf
}

src_configure() {
	export ac_cv_lib_numa_numa_run_on_node=$(usex numa)
	econf \
		--sbindir=/sbin \
		$(use_with caps libcap-ng)
}

src_install() {
	emake install DESTDIR="${D}" || die
	newinitd "${FILESDIR}"/irqbalance.init-0.55-r2 irqbalance || die
	newconfd "${FILESDIR}"/irqbalance.confd irqbalance
}
