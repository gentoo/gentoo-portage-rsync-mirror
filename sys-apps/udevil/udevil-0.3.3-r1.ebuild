# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/udevil/udevil-0.3.3-r1.ebuild,v 1.4 2012/11/29 02:05:39 ssuominen Exp $

EAPI=4

inherit eutils autotools user

DESCRIPTION="mount and unmount removable devices without a password"
HOMEPAGE="http://ignorantguru.github.com/udevil/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-shells/bash-4.0
	dev-libs/glib:2
	sys-apps/util-linux
	>=virtual/udev-143
	virtual/acl"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup(){
	enewgroup plugdev
}

src_prepare() {
	epatch "${FILESDIR}/${P}-flags.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-setfacl-prog="$(type -P setfacl)"
}

src_install() {
	default
	fowners root:plugdev /usr/bin/udevil
	fperms 4754 /usr/bin/udevil
}

pkg_postinst() {
	einfo
	elog "Please add your user to the plugdev group"
	elog "to be able to use ${PN} as a user"
	elog
	elog "Optional dependencies:"
	elog "  gnome-extra/zenity (devmon popups)"
	elog "  net-fs/cifs-utils  (mounting samba shares)"
	elog "  net-fs/curlftpfs   (mounting ftp shares)"
	elog "  net-fs/nfs-utils   (mounting nfs shares)"
	elog "  sys-fs/sshfs-fuse  (mounting sftp shares)"
	elog "  virtual/eject      (eject via devmon)"
	if ! has_version 'sys-fs/udisks' ; then
		elog
		elog "When using ${PN} without udisks, and without the udisks-daemon running,"
		elog "you may need to enable kernel polling for device media changes to be detected."
		elog "See http://ignorantguru.github.com/${PN}/#polling"
		has_version '<virtual/udev-173' && ewarn "You need at least udev-173"
		kernel_is lt 2 6 38 && ewarn "You need at least kernel 2.6.38"
		einfo
	fi
}
