# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.0.2.ebuild,v 1.3 2012/05/04 03:33:13 jdhore Exp $

EAPI="2"

inherit autotools

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
# TODO restore <mirror://sourceforge/xmlstar/${P}.tar.gz> once it's up
SRC_URI="http://xmlstar.sourceforge.net/downloads/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.9"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Shipped configure script broken somehow:
	# All HAVE_* end up undefined in config.h.
	# Therefore we re-created it
	eautoreconf
}

src_configure() {
	local xsltlibs=$(pkg-config --libs libxslt libexslt)
	local xmllibs=$(pkg-config --libs libxml-2.0)

	LIBXSLT_PREFIX=/usr LIBXML_PREFIX=/usr \
		LIBXSLT_LIBS="${xsltlibs}" LIBXML_LIBS="${xmllibs}" \
		econf
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dosym /usr/bin/xml /usr/bin/xmlstarlet

	dodoc AUTHORS ChangeLog README TODO
	dohtml -r *
}

src_test() {
	cd tests
	sh runTests || die "sh runTests failed."
}
