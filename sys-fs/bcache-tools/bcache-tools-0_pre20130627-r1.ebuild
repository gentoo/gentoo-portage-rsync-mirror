# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bcache-tools/bcache-tools-0_pre20130627-r1.ebuild,v 1.3 2013/10/28 10:53:29 jlec Exp $

EAPI=5

inherit toolchain-funcs udev

DESCRIPTION="Tools for bachefs"
HOMEPAGE="http://bcache.evilpiepirate.org/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	tc-export CC
	sed \
		-e '/^CFLAGS/d' \
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

pkg_postinst() {
	udev_reload
}
