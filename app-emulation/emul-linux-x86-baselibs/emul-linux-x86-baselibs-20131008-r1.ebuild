# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-20131008-r1.ebuild,v 1.1 2013/10/09 07:25:49 tetromino Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="Artistic GPL-1 GPL-2 GPL-3 BSD BSD-2 BZIP2 AFL-2.1 LGPL-2.1 BSD-4 MIT
	public-domain LGPL-3 LGPL-2 GPL-2-with-exceptions MPL-1.1 OPENLDAP
	Sleepycat UoI-NCSA ZLIB openafs-krb5-a HPND ISC RSA IJG libmng libtiff
	openssl tcp_wrappers_license"

KEYWORDS="-* ~amd64"
IUSE="abi_x86_32"

DEPEND=""
RDEPEND="!<app-emulation/emul-linux-x86-medialibs-10.2
	abi_x86_32? (
		>=sys-libs/zlib-1.2.8-r1[abi_x86_32(-)]
		>=app-arch/bzip2-1.0.6-r4[abi_x86_32(-)]
		>=media-libs/libpng-1.5.16-r1:0[abi_x86_32(-)]
		>=dev-libs/udis86-1.7-r2[abi_x86_32(-)]
		>=virtual/libffi-3.0.13-r1[abi_x86_32(-)]
		>=sys-devel/llvm-3.3-r1[abi_x86_32(-)]
		>=media-libs/libpng-1.2.50-r1:1.2[abi_x86_32(-)]
		>=media-libs/libjpeg-turbo-1.3.0-r2:0[abi_x86_32(-)]
		>=sys-libs/libraw1394-2.1.0-r1[abi_x86_32(-)]
		>=sys-libs/libavc1394-0.5.4-r1[abi_x86_32(-)]
		>=dev-libs/expat-2.1.0-r3[abi_x86_32(-)]
		>=virtual/libusb-0-r1:0[abi_x86_32(-)]
		>=virtual/libusb-1-r1:1[abi_x86_32(-)]
		>=virtual/udev-206-r1[abi_x86_32(-)]
		>=media-libs/tiff-4.0.3-r5:0[abi_x86_32(-)]
		>=sys-apps/attr-2.4.47-r1[abi_x86_32(-)]
		>=dev-libs/glib-2.36.3-r2:2[abi_x86_32(-)]
		>=media-libs/lcms-2.5-r1:2[abi_x86_32(-)]
		>=app-text/libpaper-1.1.24-r2[abi_x86_32(-)]
		>=media-libs/tiff-3.9.7-r1:3[abi_x86_32(-)]
		|| (
			>=dev-libs/elfutils-0.155-r1[abi_x86_32(-)]
			>=dev-libs/libelf-0.8.13-r2[abi_x86_32(-)]
		)
		>=sys-libs/e2fsprogs-libs-1.42.7-r1[abi_x86_32(-)]
		>=sys-libs/ncurses-5.9-r3[abi_x86_32(-)]
		>=sys-libs/gpm-1.20.7-r2[abi_x86_32(-)]
	)
	>=sys-libs/glibc-2.15" # bug 340613

PYTHON_UPDATER_IGNORE="1"

src_prepare() {
	export ALLOWED="(${S}/lib32/security/pam_filter/upperLOWER|${S}/etc/env.d|${S}/lib32/security/pam_ldap.so)"
	emul-linux-x86_src_prepare
	rm -rf "${S}/etc/env.d/binutils/" \
			"${S}/usr/i686-pc-linux-gnu/lib" \
			"${S}/usr/lib32/engines/" \
			"${S}/usr/lib32/openldap/" || die

	ln -s ../share/terminfo "${S}/usr/lib32/terminfo" || die

	# Remove migrated stuff.
	use abi_x86_32 && rm -f $(cat "${FILESDIR}/remove-native")
}
