# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skyutils/skyutils-2.8-r2.ebuild,v 1.7 2013/07/26 01:33:13 creffett Exp $

EAPI=5
inherit eutils flag-o-matic autotools

DESCRIPTION="Library of assorted C utility functions."
HOMEPAGE="None available" # was "http://zekiller.skytech.org/coders_en.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_prepare() {
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.in || die
	epatch "${FILESDIR}"/${P}-libs.patch
	eautoreconf
}

src_configure() {
	append-flags -D_GNU_SOURCE
	econf `use_enable ssl` || die "./configure failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
}
