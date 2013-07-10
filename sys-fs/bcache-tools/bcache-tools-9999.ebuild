# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bcache-tools/bcache-tools-9999.ebuild,v 1.2 2013/07/10 06:12:46 jlec Exp $

EAPI=5

inherit git-2 toolchain-funcs udev

DESCRIPTION="Tools for bachefs"
HOMEPAGE="http://bcache.evilpiepirate.org/"
SRC_URI=""
EGIT_REPO_URI="http://evilpiepirate.org/git/bcache-tools.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

src_prepare() {
	tc-export CC
	sed \
		-e '/CFLAGS/d' \
		-i Makefile || die
}

src_install() {
	into /
	dosbin make-bcache probe-bcache bcache-super-show
	doman *.8

	insinto /etc/initramfs-tools/hooks/bcache
	doins initramfs/hook

	udev_dorules 61-bcache.rules

	exeinto $(get_udevdir)
	doexe bcache-register

	dodoc README
}
