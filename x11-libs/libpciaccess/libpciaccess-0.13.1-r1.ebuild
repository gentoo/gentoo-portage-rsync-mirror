# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libpciaccess/libpciaccess-0.13.1-r1.ebuild,v 1.2 2013/02/27 05:56:51 zmedico Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="Library providing generic access to the PCI bus and devices"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="minimal zlib"

DEPEND="!<x11-base/xorg-server-1.5
	zlib? (
		sys-libs/zlib
		amd64? ( abi_x86_32? (
			app-emulation/emul-linux-x86-baselibs[development] ) )
	)"
RDEPEND="${DEPEND}
	sys-apps/hwids"

pkg_setup() {
	xorg-2_pkg_setup

	XORG_CONFIGURE_OPTIONS=(
		"$(use_with zlib)"
		"--with-pciids-path=${EPREFIX}/usr/share/misc"
	)
}

src_install() {
	xorg-2_src_install

	if ! use minimal; then
		scanpci_install() {
			${BASH} "${BUILD_DIR}/libtool" --mode=install "$(type -P install)" -c "${BUILD_DIR}/scanpci/scanpci" "${ED}"/usr/bin || die
		}

		dodir /usr/bin
		multilib_foreach_abi scanpci_install
	fi
}
