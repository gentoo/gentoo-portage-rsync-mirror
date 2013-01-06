# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.3.1.ebuild,v 1.7 2012/07/10 17:56:55 ranger Exp $

EAPI="4"

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt
	virtual/libiconv"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_configure() {
	econf --disable-static-libs
}

src_install() {
	default

	dosym xml /usr/bin/xmlstarlet
	dohtml -r doc/*
}
