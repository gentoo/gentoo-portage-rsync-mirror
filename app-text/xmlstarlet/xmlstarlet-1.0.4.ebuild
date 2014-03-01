# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.0.4.ebuild,v 1.3 2014/03/01 22:22:40 mgorny Exp $

EAPI="2"

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt:0
	virtual/libiconv"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf --disable-static-libs
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dosym /usr/bin/xml /usr/bin/xmlstarlet || die

	dodoc AUTHORS ChangeLog README TODO || die
	dohtml -r doc || die
}
