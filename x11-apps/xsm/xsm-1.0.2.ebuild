# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xsm/xsm-1.0.2.ebuild,v 1.10 2012/05/11 03:06:45 aballier Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X Session Manager"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="rsh"
RDEPEND="x11-libs/libXaw
	x11-libs/libX11
	x11-libs/libXt
	x11-libs/libICE
	x11-libs/libSM
	rsh? ( net-misc/netkit-rsh )"
DEPEND="${RDEPEND}"

pkg_setup() {
	# (#158056) /usr/$(get_libdir)/X11/xsm could be a symlink
	local XSMPATH="${EROOT}usr/$(get_libdir)/X11/xsm"
	if [[ -L ${XSMPATH} ]]; then
		einfo "Removing symlink ${XSMPATH}"
		rm -f ${XSMPATH} || die "failed to remove symlink ${XSMPATH}"
	fi

	CONFIGURE_OPTIONS="$(use_with rsh rsh /usr/bin/rsh)"
	xorg-2_pkg_setup
}
