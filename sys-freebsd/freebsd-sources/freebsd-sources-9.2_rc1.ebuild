# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-9.2_rc1.ebuild,v 1.3 2013/08/11 14:34:25 aballier Exp $

inherit bsdmk freebsd flag-o-matic

DESCRIPTION="FreeBSD kernel sources"
SLOT="0"

IUSE=""

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${SYS}.tar.bz2"
fi

RDEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*
	!sys-freebsd/virtio-kmod"
DEPEND=""

RESTRICT="strip binchecks"

S="${WORKDIR}/sys"

PATCHES=( "${FILESDIR}/${PN}-9.0-disable-optimization.patch"
	"${FILESDIR}/${PN}-9.2-gentoo.patch"
	"${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	"${FILESDIR}/${PN}-6.1-ntfs.patch"
	"${FILESDIR}/${PN}-7.1-types.h-fix.patch"
	"${FILESDIR}/${PN}-8.0-subnet-route-pr40133.patch"
	"${FILESDIR}/${PN}-7.1-includes.patch"
	"${FILESDIR}/${PN}-9.0-sysctluint.patch"
	"${FILESDIR}/${PN}-9.2-no_ctf.patch"
	"${FILESDIR}/${PN}-9.2-gentoo-gcc.patch"
	"${FILESDIR}/${PN}-7.0-tmpfs_whiteout_stub.patch" )

src_unpack() {
	freebsd_src_unpack

	# This replaces the gentoover patch, it doesn't need reapply every time.
	sed -i -e 's:^REVISION=.*:REVISION="'${PVR}'":' \
		-e 's:^BRANCH=.*:BRANCH="Gentoo":' \
		-e 's:^VERSION=.*:VERSION="${TYPE} ${BRANCH} ${REVISION}":' \
		"${S}/conf/newvers.sh"

	# __FreeBSD_cc_version comes from FreeBSD's gcc.
	# on 9.0-RELEASE it's 900001.
	sed -e "s:-D_KERNEL:-D_KERNEL -D__FreeBSD_cc_version=900001:g" \
		-i "${S}/conf/kern.pre.mk" \
		-i "${S}/conf/kmod.mk" || die "Couldn't set __FreeBSD_cc_version"

	# Remove -Werror
	sed -e "s:-Werror:-Wno-error:g" \
		-i "${S}/conf/kern.pre.mk" \
		-i "${S}/conf/kmod.mk" || die
}

src_compile() {
	einfo "Nothing to compile.."
}

src_install() {
	insinto "/usr/src/sys"
	doins -r "${S}/"*
}

pkg_preinst() {
	if [[ -L "${ROOT}/usr/src/sys" ]]; then
		einfo "/usr/src/sys is a symlink, removing it..."
		rm -f "${ROOT}/usr/src/sys"
	fi

	if use sparc-fbsd ; then
		ewarn "WARNING: kldload currently causes kernel panics"
		ewarn "on sparc64. This is probably a gcc-4.1 issue, but"
		ewarn "we need gcc-4.1 to compile the kernel correctly :/"
		ewarn "Please compile all modules you need into the kernel"
	fi
}
