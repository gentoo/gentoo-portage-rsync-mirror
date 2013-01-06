# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.15.ebuild,v 1.7 2011/07/15 15:59:26 xarthisius Exp $

EAPI=2

inherit flag-o-matic

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
HOMEPAGE="http://jfs.sourceforge.net/"
SRC_URI="http://jfs.sourceforge.net/project/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh ~sparc x86"
IUSE="static"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_configure() {
	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	use static && append-ldflags -static
	econf --sbindir=/sbin
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README

	rm -f "${D}"/sbin/{mkfs,fsck}.jfs
	dosym /sbin/jfs_mkfs /sbin/mkfs.jfs
	dosym /sbin/jfs_fsck /sbin/fsck.jfs
}
