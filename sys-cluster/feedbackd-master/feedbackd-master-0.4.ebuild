# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/feedbackd-master/feedbackd-master-0.4.ebuild,v 1.7 2009/09/23 20:40:27 patrick Exp $

inherit eutils

DESCRIPTION="Feedbackd is an add-on to the Linux Virtual Server project (LVS) to provide
dynamic feedback of server health."

HOMEPAGE="http://ozlabs.org/~jk/projects/feedbackd/"
LICENSE="GPL-2"
DEPEND="dev-libs/libxml2
	>=sys-cluster/ipvsadm-1.24
	dev-lang/perl"

SRC_URI="mirror://sourceforge/feedbackd/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86"

src_compile() {
	einfo "Note: feedbackd-master needs a kernel with ipvs support and with ipvs enabled"

	econf \
		--sysconfdir=/etc \
		--localstatedir=/var \
		|| die "bad ./configure"

	emake || die
}

src_install() {
	einstall || die
	dodoc ChangeLog NEWS README
}
