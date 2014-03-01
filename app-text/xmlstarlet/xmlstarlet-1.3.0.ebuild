# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-1.3.0.ebuild,v 1.2 2014/03/01 22:22:40 mgorny Exp $

EAPI="4"

DESCRIPTION="A set of tools to transform, query, validate, and edit XML documents"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt:0
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
