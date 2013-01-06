# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.19-r2.ebuild,v 1.11 2008/10/26 06:41:46 vapier Exp $

inherit eutils

DESCRIPTION="Reiserfs Utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/fs/reiserfs/"
SRC_URI="mirror://kernel/linux/utils/fs/reiserfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 -sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-unaligned.patch
	epatch "${FILESDIR}"/${P}-fsck-n.patch
}

src_compile() {
	econf --prefix=/ || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	emake DESTDIR="${D}" install || die "Failed to install"
	dosym reiserfsck /sbin/fsck.reiserfs
	dosym mkreiserfs /sbin/mkfs.reiserfs
	dodoc ChangeLog INSTALL README
}
