# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/aufs-sources/aufs-sources-3.10.13.ebuild,v 1.2 2013/09/30 14:45:29 jlec Exp $

EAPI=5

ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="20"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2 eutils
detect_version
detect_arch

AUFS_VERSION=3.10_p20130923
AUFS_TARBALL="aufs-sources-${AUFS_VERSION}.tar.xz"
# git archive -v --remote=git://git.code.sf.net/p/aufs/aufs3-standalone aufs${AUFS_VERSION/_p*} > aufs-sources-${AUFS_VERSION}.tar
AUFS_URI="http://dev.gentoo.org/~jlec/distfiles/${AUFS_TARBALL}"

KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches http://aufs.sourceforge.net/"
IUSE="deblob experimental module proc"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree and aufs3 support"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${AUFS_URI}"

UNIPATCH_LIST="
	"${WORKDIR}"/aufs3-kbuild.patch
	"${WORKDIR}"/aufs3-base.patch"

PDEPEND=">=sys-fs/aufs-util-3.9"

src_unpack() {
	use module && UNIPATCH_LIST+=" "${WORKDIR}"/aufs3-standalone.patch"
	use proc && UNIPATCH_LIST+=" "${WORKDIR}"/aufs3-proc_map.patch"
	unpack ${AUFS_TARBALL}
	kernel-2_src_unpack
}

src_prepare() {
	if ! use module; then
		sed -e 's:tristate:bool:g' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	if ! use proc; then
		sed '/config AUFS_PROC_MAP/,/^$/d' -i "${WORKDIR}"/fs/aufs/Kconfig || die
	fi
	cp -f "${WORKDIR}"/include/linux/aufs_type.h include/linux/aufs_type.h || die
	cp -f "${WORKDIR}"/include/uapi/linux/aufs_type.h include/uapi/linux/aufs_type.h || die
	cp -rf "${WORKDIR}"/{Documentation,fs} . || die
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	has_version sys-fs/aufs-util && \
		einfo "In order to use aufs FS you need to install sys-fs/aufs-util"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
