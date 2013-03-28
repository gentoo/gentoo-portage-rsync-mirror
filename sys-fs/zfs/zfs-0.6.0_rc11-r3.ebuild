# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs/zfs-0.6.0_rc11-r3.ebuild,v 1.2 2013/03/28 22:19:57 ryao Exp $

EAPI="4"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

inherit bash-completion-r1 flag-o-matic toolchain-funcs autotools-utils udev

if [ ${PV} == "9999" ] ; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/zfsonlinux/${PN}.git"
else
	inherit eutils versionator
	MY_PV=$(replace_version_separator 3 '-')
	SRC_URI="mirror://github/zfsonlinux/${PN}/${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Userland utilities for ZFS Linux kernel module"
HOMEPAGE="http://zfsonlinux.org/"

LICENSE="BSD-2 CDDL MIT"
SLOT="0"
IUSE="custom-cflags kernel-builtin +rootfs test-suite static-libs"
RESTRICT="test"

COMMON_DEPEND="
	sys-apps/util-linux[static-libs?]
	sys-libs/zlib[static-libs(+)?]
	virtual/awk
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEPEND}
	!=sys-apps/grep-2.13*
	!kernel-builtin? ( =sys-fs/zfs-kmod-${PV}* )
	!sys-fs/zfs-fuse
	!prefix? ( virtual/udev )
	test-suite? (
		sys-apps/util-linux
		sys-devel/bc
		sys-block/parted
		sys-fs/lsscsi
		sys-fs/mdadm
		sys-process/procps
		virtual/modutils
		)
	rootfs? (
		app-arch/cpio
		app-misc/pax-utils
		)
"

src_prepare() {
	# Update paths
	sed -e "s|/sbin/lsmod|/bin/lsmod|" \
		-e "s|/usr/bin/scsi-rescan|/usr/sbin/rescan-scsi-bus|" \
		-e "s|/sbin/parted|/usr/sbin/parted|" \
		-i scripts/common.sh.in

	autotools-utils_src_prepare
}

src_configure() {
	use custom-cflags || strip-flags
	local myeconfargs=(
		--bindir="${EPREFIX}/bin"
		--sbindir="${EPREFIX}/sbin"
		--with-config=user
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		--with-udevdir="$(udev_get_udevdir)"
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	gen_usr_ldscript -a uutil nvpair zpool zfs
	rm -rf "${ED}usr/share/dracut"
	use test-suite || rm -rf "${ED}usr/libexec"

	newbashcomp "${FILESDIR}/bash-completion" zfs

}

pkg_postinst() {

	[ -e "${EROOT}/etc/runlevels/boot/zfs" ] \
		|| ewarn 'You should add zfs to the boot runlevel.'

	if [ -e "${EROOT}/etc/runlevels/shutdown/zfs-shutdown" ]
	then
		einfo "The zfs-shutdown script is obsolete. Removing it from runlevel."
		rm "${EROOT}/etc/runlevels/shutdown/zfs-shutdown"
	fi

}
