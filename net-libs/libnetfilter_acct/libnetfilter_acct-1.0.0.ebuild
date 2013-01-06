# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnetfilter_acct/libnetfilter_acct-1.0.0.ebuild,v 1.5 2012/12/13 17:36:06 pinkbyte Exp $

EAPI=4

inherit eutils linux-info multilib

DESCRIPTION="Userspace library providing interface to extended accounting infrastructure of NetFilter"
HOMEPAGE="http://netfilter.org/projects/libnetfilter_acct"
SRC_URI="http://www.netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="net-libs/libmnl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NETFILTER_NETLINK_ACCT"

pkg_setup() {
	kernel_is lt 3 3 && ewarn "This package will work with kernel version 3.3 or higher"
	linux-info_pkg_setup
}

src_configure() {
	econf \
		--libdir="${EPREFIX}"/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /usr/$(get_libdir)/pkgconfig/
	mv "${ED}"/{,usr/}$(get_libdir)/pkgconfig/${PN}.pc || die
	dodoc README

	if use examples; then
		find examples/ -name "Makefile*" -exec rm -f '{}' +
		dodoc -r examples/
		docompress -x /usr/share/doc/${P}/examples
	fi

	prune_libtool_files
}
