# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs/zfs-0.6.0_rc14.ebuild,v 1.2 2013/02/03 15:51:45 ryao Exp $

EAPI="4"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

if [ ${PV} == "9999" ] ; then
	inherit git-2 linux-mod
	EGIT_REPO_URI="git://github.com/zfsonlinux/${PN}.git"
else
	inherit eutils versionator
	MY_PV=$(replace_version_separator 3 '-')
	SRC_URI="https://github.com/zfsonlinux/${PN}/archive/${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}-${PN}-${MY_PV}"
	KEYWORDS="~amd64"
fi

inherit bash-completion-r1 flag-o-matic toolchain-funcs autotools-utils udev

DESCRIPTION="Userland utilities for ZFS Linux kernel module"
HOMEPAGE="http://zfsonlinux.org/"

LICENSE="BSD-2 CDDL MIT"
SLOT="0"
IUSE="custom-cflags kernel-builtin +rootfs test-suite static-libs"
RESTRICT="test"

COMMON_DEPEND="
	sys-apps/util-linux[static-libs?]
	sys-libs/zlib[static-libs(+)?]
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
		sys-apps/gawk
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

pkg_setup() {
	:
}

src_prepare() {
	# Workaround for hard coded path
	sed -i "s|/sbin/lsmod|/bin/lsmod|" scripts/common.sh.in || die
	# Workaround rename
	sed -i "s|/usr/bin/scsi-rescan|/usr/sbin/rescan-scsi-bus|" scripts/common.sh.in || die

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

	if ! use kernel-builtin && [ ${PV} = "9999" ]
	then
		einfo "Adding ${P} to the module database to ensure that the"
		einfo "kernel modules and userland utilities stay in sync."
		update_moduledb
	fi

	[ -e "${EROOT}/etc/runlevels/boot/zfs" ] \
		|| ewarn 'You should add zfs to the boot runlevel.'

	if [ -e "${EROOT}/etc/runlevels/shutdown/zfs-shutdown" ]
	then
		einfo "The zfs-shutdown script is obsolete. Removing it from runlevel."
		rm "${EROOT}/etc/runlevels/shutdown/zfs-shutdown"
	fi

	if use rootfs
	then
		ewarn "sys-boot/grub:2 lacks support for feature flags."
		ewarn "If your /boot is on a ZFS pool, the pool must be version 28 or earlier."
		ewarn "Do *NOT* upgrade any pools used for booting to use feature flags."
	fi
}

pkg_postrm() {
	if ! use kernel-builtin && [ ${PV} = "9999" ]
	then
		remove_moduledb
	fi
}
