# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnftnl/libnftnl-1.0.0.ebuild,v 1.1 2014/01/20 19:54:23 chainsaw Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Netlink API to the in-kernel nf_tables subsystem"
HOMEPAGE="http://www.netfilter.org/projects/libnftnl"
SRC_URI="http://netfilter.org/projects/${PN}/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux"
IUSE="examples static-libs"

RDEPEND="
	net-libs/libmnl
"

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	gen_usr_ldscript -a nftnl
	prune_libtool_files

	if use examples; then
		find examples/ -name 'Makefile*' -delete
		dodoc -r examples/
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
