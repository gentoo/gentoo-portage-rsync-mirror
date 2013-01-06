# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libmcpp/libmcpp-2.7.ebuild,v 1.1 2009/01/07 15:12:29 b33fc0d3 Exp $

inherit eutils

MY_P=${P/lib/}

DESCRIPTION="A portable C++ preprocessor"
HOMEPAGE="http://mcpp.sourceforge.net"
SRC_URI="mirror://sourceforge/mcpp/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~arm"
IUSE=""

DEPEND="app-arch/gzip"

S=${WORKDIR}/${MY_P}

QA_TEXTRELS="usr/lib/libmcpp.so.0.1.0"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-stpcpy-gcc4.3.patch"
}

src_compile() {
	econf --enable-mcpplib
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
