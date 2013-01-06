# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cilk/cilk-5.4.6-r1.ebuild,v 1.2 2012/11/13 05:33:12 bicatali Exp $

EAPI=4
inherit flag-o-matic autotools eutils

DESCRIPTION="Language for multithreaded parallel programming based on ANSI C"
HOMEPAGE="http://supertech.csail.mit.edu/cilk"
SRC_URI="http://supertech.csail.mit.edu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	eautoreconf
}

src_configure() {
	append-cppflags -D_XOPEN_SOURCE=500
	econf --with-perfctr=no $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README THANKS
	use doc && dodoc doc/manual.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
