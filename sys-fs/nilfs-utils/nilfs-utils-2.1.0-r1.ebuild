# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/nilfs-utils/nilfs-utils-2.1.0-r1.ebuild,v 1.2 2012/05/17 20:43:48 mr_bones_ Exp $

EAPI=3

inherit multilib linux-info

DESCRIPTION="A New Implementation of a Log-structured File System for Linux"
HOMEPAGE="http://www.nilfs.org/"
SRC_URI="http://www.nilfs.org/download/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="static-libs"

RDEPEND="sys-libs/e2fsprogs-libs"
DEPEND="${DEPEND}
	sys-kernel/linux-headers"

CONFIG_CHECK="~POSIX_MQUEUE"

src_configure() {
	econf $(use_enable static-libs static) \
		--libdir=/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die

	rm -f "${ED}"/$(get_libdir)/*.la || die
}
