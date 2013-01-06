# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmnl/libmnl-1.0.1.ebuild,v 1.6 2012/08/02 01:59:31 jer Exp $

EAPI=4

inherit multilib

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

src_configure() {
	econf \
		--libdir="${EPREFIX}"/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/$(get_libdir)/pkgconfig/
	mv "${ED}"/{,usr/}$(get_libdir)/pkgconfig/libmnl.pc || die
	dodoc README

	if use examples; then
		find examples/ -name "Makefile*" -exec rm -f '{}' +
		dodoc -r examples/
		docompress -x /usr/share/doc/${P}/examples
	fi

	find "${ED}" -name '*.la' -exec rm -f '{}' +
}
