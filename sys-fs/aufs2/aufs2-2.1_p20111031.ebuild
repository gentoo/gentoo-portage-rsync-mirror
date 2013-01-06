# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs2/aufs2-2.1_p20111031.ebuild,v 1.2 2012/05/24 02:55:24 vapier Exp $

EAPI=4

inherit linux-mod multilib toolchain-funcs eutils

AUFS_VERSION="${PV%%_p*}"

DESCRIPTION="An entirely re-designed and re-implemented Unionfs"
HOMEPAGE="http://aufs.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fuse pax_kernel hfs inotify kernel-patch nfs ramfs"

DEPEND="dev-vcs/git"
RDEPEND="
	!sys-fs/aufs
	!sys-fs/aufs3"

S="${WORKDIR}"/${PN}-standalone

MODULE_NAMES="aufs(misc:${S})"

pkg_setup() {
	CONFIG_CHECK="${CONFIG_CHECK} ~EXPERIMENTAL"
	use inotify && CONFIG_CHECK="${CONFIG_CHECK} ~FSNOTIFY"
	use nfs && CONFIG_CHECK="${CONFIG_CHECK} EXPORTFS"
	use fuse && CONFIG_CHECK="${CONFIG_CHECK} ~FUSE_FS"
	use hfs && CONFIG_CHECK="${CONFIG_CHECK} ~HFSPLUS_FS"

	# this is needed so merging a binpkg ${PN} is possible w/out a kernel unpacked on the system
	[ -n "$PKG_SETUP_HAS_BEEN_RAN" ] && return

	get_version
	kernel_is lt 2 6 31 && die "kernel too old"
	kernel_is gt 2 6 34 && die "kernel too new"

	linux-mod_pkg_setup
	if ! ( patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-standalone-${KV_PATCH}.patch >/dev/null && \
		patch -p1 --dry-run --force -R -d ${KV_DIR} < "${FILESDIR}"/${PN}-base-${KV_PATCH}.patch >/dev/null ); then
		if use kernel-patch; then
			cd ${KV_DIR}
			ewarn "Patching your kernel..."
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/${AUFS_VERSION}/${PN}-standalone-${KV_PATCH}.patch >/dev/null
			patch --no-backup-if-mismatch --force -p1 -R -d ${KV_DIR} < "${FILESDIR}"/${AUFS_VERSION}/${PN}-base-${KV_PATCH}.patch >/dev/null
			epatch "${FILESDIR}"/${AUFS_VERSION}/${PN}-{base,standalone}-${KV_PATCH}.patch
			ewarn "You need to compile your kernel with the applied patch"
			ewarn "to be able to load and use the aufs kernel module"
		else
			eerror "You need to apply a patch to your kernel to compile and run the ${PN} module"
			eerror "Either enable the kernel-patch useflag to do it with this ebuild"
			eerror "or apply ${FILESDIR}/${PN}-base-${KV_PATCH}.patch and"
			eerror "${FILESDIR}/${PN}-standalone-${KV_PATCH}.patch by hand"
			die "missing kernel patch, please apply it first"
		fi
	fi
	export PKG_SETUP_HAS_BEEN_RAN=1
}

set_config() {
	for option in $*; do
		grep -q "^CONFIG_AUFS_${option} =" config.mk || die "${option} is not a valid config option"
		sed "/^CONFIG_AUFS_${option}/s:=:= y:g" -i config.mk || die
	done
}

src_prepare() {
	local branch=origin/aufs${AUFS_VERSION}-${KV_PATCH}
	git checkout -q $branch || die

	# All config options to off
	sed "s:= y:=:g" -i config.mk || die

	set_config RDU BRANCH_MAX_127 SBILIST

	use debug && set_config DEBUG
	use fuse && set_config BR_FUSE POLL
	use hfs && set_config BR_HFSPLUS
	use inotify && set_config HNOTIFY HFSNOTIFY
	use nfs && set_config EXPORT
	use nfs && use amd64 && set_config INO_T_64
	use ramfs && set_config BR_RAMFS

	if use pax_kernel ; then
		epatch "${FILESDIR}"/pax.patch
	fi

	sed -i "s:aufs.ko usr/include/linux/aufs_type.h:aufs.ko:g" Makefile || die
	sed -i "s:__user::g" include/linux/aufs_type.h || die

	cd "${WORKDIR}"/${PN}-util
	git checkout -q origin/aufs${AUFS_VERSION}
	sed -i "/LDFLAGS += -static -s/d" Makefile || die
	sed -i -e "s:m 644 -s:m 644:g" -e "s:/usr/lib:/usr/$(get_libdir):g" libau/Makefile || die
}

src_compile() {
	local ARCH=x86

	emake CC=$(tc-getCC) CONFIG_AUFS_FS=m KDIR=${KV_DIR}

	cd "${WORKDIR}"/${PN}-util
	emake CC=$(tc-getCC) AR=$(tc-getAR) KDIR=${KV_DIR} C_INCLUDE_PATH="${S}"/include
}

src_install() {
	linux-mod_src_install
	dodoc README
	docinto design
	dodoc design/*.txt
	cd "${WORKDIR}"/${PN}-util
	emake DESTDIR="${D}" KDIR=${KV_DIR} install
	docinto
	newdoc README README-utils
}
