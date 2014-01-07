# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.10.7-r1.ebuild,v 1.2 2014/01/07 19:15:02 tomwij Exp $

EAPI="5"
ETYPE="sources"
K_GENPATCHES_VER="1"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
IUSE="deblob"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

GENPATCH_PREFIX="genpatches-${PV}-${K_GENPATCHES_VER}"

SRC_URI="
	${KERNEL_URI}
	mirror://gentoo/${GENPATCH_PREFIX}.base.tar.xz
	mirror://gentoo/${GENPATCH_PREFIX}.extras.tar.xz
	${ARCH_URI}"

UNIPATCH_LIST="
	${GENPATCH_PREFIX}.base.tar.xz
	${GENPATCH_PREFIX}.extras.tar.xz"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
