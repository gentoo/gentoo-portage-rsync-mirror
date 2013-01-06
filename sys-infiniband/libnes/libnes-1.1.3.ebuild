# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libnes/libnes-1.1.3.ebuild,v 1.1 2012/04/18 16:43:44 alexxy Exp $

EAPI=4

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="NetEffect RNIC Userspace Library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="static-libs"

DEPEND="sys-infiniband/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"
block_other_ofed_versions

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || rm -f "${D}"usr/$(get_libdir)/${PN}.la
}
