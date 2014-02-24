# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/nilfs-utils/nilfs-utils-2.1.5-r1.ebuild,v 1.3 2014/02/24 00:48:55 phajdan.jr Exp $

EAPI=5

inherit multilib linux-info

DESCRIPTION="A New Implementation of a Log-structured File System for Linux"
HOMEPAGE="http://www.nilfs.org/"
SRC_URI="http://www.nilfs.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ppc ~ppc64 x86"
IUSE="static-libs"

RDEPEND="sys-libs/e2fsprogs-libs
	sys-apps/util-linux"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

CONFIG_CHECK="~POSIX_MQUEUE"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--libdir=/$(get_libdir) \
		--enable-libmount
}

src_install() {
	default
	rm -f "${ED}"/$(get_libdir)/*.la || die
}
