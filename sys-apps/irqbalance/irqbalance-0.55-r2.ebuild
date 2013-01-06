# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.55-r2.ebuild,v 1.5 2012/05/04 09:17:28 jdhore Exp $

inherit eutils

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://www.irqbalance.org/releases/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-libs/glib-2*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	into /
	dosbin irqbalance || die "dosbin failed"
	doman "${FILESDIR}"/irqbalance.1
	newinitd "${FILESDIR}"/irqbalance.init-0.55-r2 irqbalance
	newconfd "${FILESDIR}"/irqbalance.confd irqbalance
}
