# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/orc/orc-0.4.10.ebuild,v 1.2 2012/11/09 17:38:42 tetromino Exp $

EAPI=3
inherit autotools

DESCRIPTION="The Oil Runtime Compiler, a just-in-time compiler for array operations"
HOMEPAGE="http://code.entropywave.com/projects/orc/"
SRC_URI="http://code.entropywave.com/download/orc/${P}.tar.gz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs examples"

src_prepare() {
	if ! use examples; then
		sed -i -e '/SUBDIRS/s:examples::' Makefile.am || die
		AT_M4DIR="m4" eautoreconf
	fi
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-dependency-tracking \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO

	find "${ED}" -name '*.la' -delete
}
