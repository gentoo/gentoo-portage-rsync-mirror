# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-9.2_rc1.ebuild,v 1.5 2013/08/11 21:23:03 aballier Exp $

EAPI=5

inherit bsdmk freebsd flag-o-matic toolchain-funcs

DESCRIPTION="FreeBSD kernel sources"
SLOT="0"

IUSE="+build-generic profile"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${SYS}.tar.bz2"
fi

RDEPEND="=sys-freebsd/freebsd-mk-defs-${RV}*
	!sys-freebsd/virtio-kmod"
DEPEND="build-generic? (
		=sys-freebsd/freebsd-usbin-${RV}*
		=sys-freebsd/freebsd-mk-defs-${RV}*
	)"

RESTRICT="strip binchecks"

S="${WORKDIR}/sys"

KERN_BUILD=GENERIC

PATCHES=( "${FILESDIR}/${PN}-9.0-disable-optimization.patch"
	"${FILESDIR}/${PN}-9.2-gentoo.patch"
	"${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	"${FILESDIR}/${PN}-6.1-ntfs.patch"
	"${FILESDIR}/${PN}-7.1-types.h-fix.patch"
	"${FILESDIR}/${PN}-8.0-subnet-route-pr40133.patch"
	"${FILESDIR}/${PN}-7.1-includes.patch"
	"${FILESDIR}/${PN}-9.0-sysctluint.patch"
	"${FILESDIR}/${PN}-9.2-gentoo-gcc.patch"
	"${FILESDIR}/${PN}-7.0-tmpfs_whiteout_stub.patch" )

src_prepare() {
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

	# Only used with USE=build-generic, let the kernel build with its own flags, its safer.
	unset LDFLAGS CFLAGS CXXFLAGS ASFLAGS KERNEL
}

src_configure() {
	if use build-generic ; then
		tc-export CC
		cd "${S}/$(tc-arch-kernel)/conf" || die
		config ${KERN_BUILD} || die
	fi
}

src_compile() {
	if use build-generic ; then
		cd "${S}/$(tc-arch-kernel)/compile/${KERN_BUILD}" || die
		freebsd_src_compile depend
		freebsd_src_compile
	else
		einfo "Nothing to compile.."
	fi
}

src_install() {
	if use build-generic ; then
		cd "${S}/$(tc-arch-kernel)/compile/${KERN_BUILD}" || die
		freebsd_src_install
		rm -rf "${S}/$(tc-arch-kernel)/compile/${KERN_BUILD}"
		cd "${S}"
	fi

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
