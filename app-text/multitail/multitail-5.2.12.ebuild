# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/multitail/multitail-5.2.12.ebuild,v 1.2 2013/02/25 19:07:13 jlec Exp $

EAPI=5

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Tail with multiple windows"
HOMEPAGE="http://www.vanheusden.com/multitail/"
SRC_URI="http://www.vanheusden.com/multitail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="debug doc examples"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/5.2.2-as-needed.patch

	use x86-interix && epatch "${FILESDIR}"/${PN}-5.2.6-interix.patch

	sed -e '/gcc/d' -i Makefile || die
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

	use doc && dohtml manual.html

	docinto examples
	use examples && dodoc colors-example.{pl,sh} convert-{geoip,simple}.pl
}
