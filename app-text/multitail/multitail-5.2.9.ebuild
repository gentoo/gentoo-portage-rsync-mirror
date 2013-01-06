# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-5.2.9.ebuild,v 1.5 2012/02/28 21:54:49 ranger Exp $

EAPI="4"

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Tail with multiple windows"
HOMEPAGE="http://www.vanheusden.com/multitail/index.html"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="debug doc examples"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/5.2.2-as-needed.patch \
		"${FILESDIR}"/5.2.6-buffer-overflow.patch

	use x86-interix && epatch "${FILESDIR}"/${PN}-5.2.6-interix.patch
}

src_configure() {
	tc-export CC
	use debug && append-flags "-D_DEBUG"
	use prefix && sed "s:DESTDIR=/:DESTDIR=${EROOT}:g" -i Makefile
}

src_install () {
	dobin multitail

	insinto /etc
	doins multitail.conf

	dodoc Changes readme.txt thanks.txt
	doman multitail.1

	if use examples; then
		docinto examples
		dodoc colors-example.{pl,sh} convert-{geoip,simple}.pl
	fi

	if use doc; then
		dohtml manual.html
	fi
}
