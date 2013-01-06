# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/fax4cups/fax4cups-1.28.ebuild,v 1.5 2012/08/02 08:21:51 sbriesen Exp $

DESCRIPTION="efax/hylafax backend for CUPS"

HOMEPAGE="http://vigna.dsi.unimi.it/fax4CUPS/"
SRC_URI="http://vigna.dsi.unimi.it/fax4CUPS/fax4CUPS-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
DEPEND="net-print/cups"
RDEPEND="${DEPEND}
	|| ( net-misc/hylafaxplus net-misc/efax net-dialup/mgetty )
	app-admin/sudo"

S=${WORKDIR}/fax4CUPS-${PV}

src_install() {
	doman fax4CUPS.1

	# Backends
	exeinto $(cups-config --serverbin)/backend
	doexe efax hylafax

	# PPD's
	insinto /usr/share/cups/model
	doins efax.ppd hylafax.ppd
}

pkg_postinst() {
	elog "Please execute '/etc/init.d/cups restart'"
	elog "to get these *.ppd files working properly"
}
