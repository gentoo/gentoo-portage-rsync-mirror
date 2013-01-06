# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.0.6.ebuild,v 1.5 2012/05/04 03:33:13 jdhore Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.23
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt
	virtual/libiconv"

DEPEND="${RDEPEND}
	sys-apps/sed
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-setmode.patch
	eautoreconf
}

src_configure() {
	econf --disable-static-libs
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dosym /usr/bin/xml /usr/bin/xmlstarlet || die

	dodoc AUTHORS ChangeLog README TODO || die
	dohtml -r doc || die
}
