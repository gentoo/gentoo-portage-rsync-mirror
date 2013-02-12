# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zfs-kmod/zfs-kmod-0.6.0_rc11-r2.ebuild,v 1.1 2013/02/11 23:36:17 ryao Exp $

EAPI="4"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

inherit bash-completion-r1 flag-o-matic linux-mod toolchain-funcs autotools-utils

if [ ${PV} == "9999" ] ; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/zfsonlinux/zfs.git"
else
	inherit eutils versionator
	MY_PV=$(replace_version_separator 3 '-')
	SRC_URI="https://github.com/downloads/zfsonlinux/zfs/zfs-${MY_PV}.tar.gz"
	S="${WORKDIR}/zfs-${MY_PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Linux ZFS kernel module for sys-fs/zfs"
HOMEPAGE="http://zfsonlinux.org/"

LICENSE="CDDL"
SLOT="0"
IUSE="custom-cflags debug +rootfs"
RESTRICT="test"

DEPEND="
	=sys-kernel/spl-${PV}*
	virtual/awk
"

RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse
"

pkg_setup() {
	CONFIG_CHECK="!DEBUG_LOCK_ALLOC
		BLK_DEV_LOOP
		EFI_PARTITION
		IOSCHED_NOOP
		MODULES
		!PAX_KERNEXEC_PLUGIN_METHOD_OR
		ZLIB_DEFLATE
		ZLIB_INFLATE
	"

	use rootfs && \
		CONFIG_CHECK="${CONFIG_CHECK} BLK_DEV_INITRD
			DEVTMPFS"

	kernel_is ge 2 6 26 || die "Linux 2.6.26 or newer required"

	[ ${PV} != "9999" ] && \
		{ kernel_is le 3 6 || die "Linux 3.6 is the latest supported version."; }

	check_extra_config
}

src_prepare() {
	if [ ${PV} != "9999" ]
	then
		# Fix various deadlocks
		epatch "${FILESDIR}/${P}-fix-32-bit-integer-size-mismatch.patch"
		epatch "${FILESDIR}/${P}-fix-i386-infinite-loop.patch"
		epatch "${FILESDIR}/${P}-fix-rename-failure.patch"
		epatch "${FILESDIR}/${P}-fix-zvol_probe-null.patch"
		epatch "${FILESDIR}/${P}-return-positive-error.patch"

		# Linux 3.6 Support
		epatch "${FILESDIR}/${P}-linux-3.6-compat-0-elevator-change.patch"
		epatch "${FILESDIR}/${P}-linux-3.6-compat-1.patch"
		epatch "${FILESDIR}/${P}-linux-3.6-compat-2.patch"
		epatch "${FILESDIR}/${P}-linux-3.6-compat-3.patch"
		epatch "${FILESDIR}/${P}-linux-3.6-compat-4.patch"
		epatch "${FILESDIR}/${P}-linux-3.6-compat-5.patch"

		# Cast constant for 32-bit compatibility
		epatch "${FILESDIR}/${PN}-0.6.0_rc14-cast-const-for-32bit-compatibility.patch"

		# Handle missing name length check in Linux VFS
		epatch "${FILESDIR}/${PN}-0.6.0_rc14-vfs-name-length-compatibility.patch"
	fi

	autotools-utils_src_prepare
}

src_configure() {
	use custom-cflags || strip-flags
	set_arch_to_kernel
	local myeconfargs=(
		--bindir="${EPREFIX}/bin"
		--sbindir="${EPREFIX}/sbin"
		--with-config=kernel
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		$(use_enable debug)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if use x86 || use arm
	then
		ewarn "32-bit kernels will likely require increasing vmalloc to"
		ewarn "at least 256M and decreasing zfs_arc_max to some value less than that."
	fi

}
