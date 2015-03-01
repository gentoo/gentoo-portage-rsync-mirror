# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bsdmk freebsd toolchain-funcs multilib

DESCRIPTION="FreeBSD CDDL (opensolaris/zfs) extra software"
SLOT="0"

IUSE="build"
LICENSE="CDDL GPL-2"

if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~amd64-fbsd ~x86-fbsd"
	SRC_URI="mirror://gentoo/${P}.tar.xz
			mirror://gentoo/${CONTRIB}.tar.xz
			mirror://gentoo/${UBIN}.tar.xz
			mirror://gentoo/${LIB}.tar.xz
			mirror://gentoo/${SBIN}.tar.xz
			mirror://gentoo/${SYS}.tar.xz
			build? ( mirror://gentoo/${INCLUDE}.tar.xz )"
fi

# sys is required.

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	=sys-freebsd/freebsd-libexec-${RV}*
	build? ( sys-apps/baselayout )"

DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	!build? ( =sys-freebsd/freebsd-sources-${RV}* )"

S="${WORKDIR}/cddl"

PATCHES=(
	"${FILESDIR}/${PN}-9.2-libpaths.patch"
	"${FILESDIR}/${PN}-10.1-underlink.patch"
	)

src_prepare() {
	if [[ ! -e "${WORKDIR}/include" ]]; then
		# Link in include headers.
		ln -s "/usr/include" "${WORKDIR}/include" || die "Symlinking /usr/include.."
	fi
}

src_install() {
	# Install libraries proper place
	local mylibdir=$(get_libdir)
	mkinstall SHLIBDIR="/usr/${mylibdir}" LIBDIR="/usr/${mylibdir}" || die

	gen_usr_ldscript -a avl nvpair umem uutil zfs zpool zfs_core

	# Install zfs volinit script.
	newinitd "${FILESDIR}"/zvol.initd-9.0 zvol

	# Install zfs script
	newinitd "${FILESDIR}"/zfs.initd zfs

	keepdir /etc/zfs
}
