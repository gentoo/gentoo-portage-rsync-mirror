# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmnl/libmnl-1.0.3-r1.ebuild,v 1.2 2013/04/29 21:16:41 jer Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="Minimalistic netlink library"
HOMEPAGE="http://netfilter.org/projects/libmnl"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux"
IUSE="examples static-libs"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--libdir="${EPREFIX}"/$(get_libdir)
}

src_install() {
	default
	dodir /usr/$(get_libdir)/pkgconfig/
	mv "${ED}"/{,usr/}$(get_libdir)/pkgconfig/libmnl.pc || die

	if use static-libs; then
		mv "${ED}"/{,usr/}$(get_libdir)/libmnl.a || die
		mv "${ED}"/{,usr/}$(get_libdir)/libmnl.la || die
		gen_usr_ldscript libmnl.so
	fi

	if use examples; then
		find examples/ -name 'Makefile*' -delete
		dodoc -r examples/
		docompress -x /usr/share/doc/${PF}/examples
	fi

	prune_libtool_files
}
