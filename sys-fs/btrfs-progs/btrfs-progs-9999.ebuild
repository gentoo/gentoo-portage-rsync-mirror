# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/btrfs-progs/btrfs-progs-9999.ebuild,v 1.21 2012/10/11 08:06:57 slyfox Exp $

EAPI=4

inherit git-2 toolchain-funcs

DESCRIPTION="Btrfs filesystem utilities"
HOMEPAGE="https://btrfs.wiki.kernel.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-libs/zlib
	sys-apps/acl
	sys-fs/e2fsprogs"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-progs.git
	https://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-progs.git"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr bindir=/sbin mandir=/usr/share/man install
}

pkg_postinst() {
	ewarn "WARNING: This version of btrfs-progs uses the latest unstable code,"
	ewarn "         and care should be taken that it is compatible with the"
	ewarn "         version of btrfs in your kernel!"
}
