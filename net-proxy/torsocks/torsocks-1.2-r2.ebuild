# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/torsocks/torsocks-1.2-r2.ebuild,v 1.3 2012/03/24 17:29:36 phajdan.jr Exp $

EAPI="4"

inherit autotools eutils multilib

DESCRIPTION="Use most socks-friendly applications with Tor."
HOMEPAGE="http://code.google.com/p/torsocks"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-1.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

# We do not depend on tor which might be running on a different box
DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/suppress-warning-msgs.patch
	epatch "${FILESDIR}"/fix-docdir.patch
	eautoreconf
}

src_configure() {
	econf --docdir=/usr/share/doc/${PF} \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README TODO INSTALL ChangeLog

	#Remove libtool .la files
	cd "${D}"/usr/$(get_libdir)/torsocks
	rm -f *.la
}
