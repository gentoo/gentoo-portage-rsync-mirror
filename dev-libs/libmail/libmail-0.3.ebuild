# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmail/libmail-0.3.ebuild,v 1.3 2010/06/28 19:41:52 fauli Exp $

DESCRIPTION="a mail handling library"
HOMEPAGE="http://libmail.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="apop debug gnutls profile sasl"

DEPEND="gnutls? ( >=net-libs/gnutls-2 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable apop) \
		$(use_enable debug ) \
		$(use_enable gnutls tls) \
		$(use_enable profile ) \
		$(use_enable sasl)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
