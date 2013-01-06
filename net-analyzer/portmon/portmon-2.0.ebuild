# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/portmon/portmon-2.0.ebuild,v 1.9 2009/09/23 18:23:33 patrick Exp $

DESCRIPTION="Portmon is a network service monitoring daemon."
SRC_URI="http://aboleo.net/software/portmon/downloads/${P}.tar.gz"
HOMEPAGE="http://aboleo.net/software/portmon/"

KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

src_compile() {
	econf --sysconfdir=/etc/portmon || die "Configure failed"
	emake || die "emake failed"
}

src_install() {
	into /usr
	dosbin src/portmon
	doman extras/portmon.8

	insinto /etc/portmon
	doins extras/portmon.hosts.sample
	dodoc AUTHORS BUGS README

	newinitd "${FILESDIR}"/portmon.init portmon
}
