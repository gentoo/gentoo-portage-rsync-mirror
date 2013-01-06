# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/sofia-sip/sofia-sip-1.12.11.ebuild,v 1.8 2012/12/31 15:52:56 ago Exp $

EAPI=4

DESCRIPTION="RFC3261 compliant SIP User-Agent library"
HOMEPAGE="http://sofia-sip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is BSD LGPL-2.1 ISC" # See COPYRIGHT
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE="ssl static-libs"

RDEPEND="dev-libs/glib:2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# tests are broken, see bugs 304607 and 330261
RESTRICT="test"

DOCS=( AUTHORS ChangeLog README README.developers RELEASE TODO )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with ssl openssl)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/lib${PN}*.la
}
