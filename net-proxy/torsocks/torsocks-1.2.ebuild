# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/torsocks/torsocks-1.2.ebuild,v 1.2 2011/12/19 15:22:55 ago Exp $

EAPI=4

inherit multilib

DESCRIPTION="Use most socks-friendly applications with Tor."
HOMEPAGE="http://code.google.com/p/torsocks"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-1.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static-libs"

# We do not depend on tor which might be running on a different box
DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	#Remove libtool .la files
	cd "${D}"/usr/$(get_libdir)/torsocks
	rm -f *.la
}
