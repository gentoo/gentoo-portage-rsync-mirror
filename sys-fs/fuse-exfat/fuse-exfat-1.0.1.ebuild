# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse-exfat/fuse-exfat-1.0.1.ebuild,v 1.4 2013/09/22 09:52:55 ssuominen Exp $

EAPI=5
inherit scons-utils toolchain-funcs #udev

DESCRIPTION="exFAT filesystem FUSE module"
HOMEPAGE="http://code.google.com/p/exfat/"
SRC_URI="http://exfat.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~arm-linux ~x86-linux"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND=${RDEPEND}

src_compile() {
	tc-export AR CC RANLIB
	escons CCFLAGS="${CFLAGS}"
}

src_install() {
	dosbin fuse/mount.exfat-fuse
	dosym mount.exfat-fuse /usr/sbin/mount.exfat

	doman */*.8
	dodoc ChangeLog

	#This shouldn't really be required. Comment it out for now.
	#udev_dorules "${FILESDIR}"/99-exfat.rules
}

pkg_postinst() {
	elog "You can emerge sys-fs/exfat-utils for dump, label, mkfs and fsck utilities."
}
