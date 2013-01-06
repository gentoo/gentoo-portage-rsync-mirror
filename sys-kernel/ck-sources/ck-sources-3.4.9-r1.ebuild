# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-3.4.9-r1.ebuild,v 1.1 2012/10/29 20:48:04 hwoarang Exp $

EAPI="3"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="10"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2 versionator
detect_version
detect_arch

DESCRIPTION="Con Kolivas' high performance patchset + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/
	http://users.on.net/~ckolivas/kernel/"

BASE_VERSION="$(get_version_component_range 1-2)"
CK_VERSION="3"

CK_URI="http://ck.kolivas.org/patches/3.0/${BASE_VERSION}/${BASE_VERSION}-ck${CK_VERSION}/patch-${BASE_VERSION}-ck${CK_VERSION}.bz2"
UNIPATCH_LIST="${DISTDIR}/patch-${BASE_VERSION}-ck${CK_VERSION}.bz2"

UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_URI}"
IUSE="deblob"
KEYWORDS="~amd64 ~x86"

src_unpack() {
	kernel-2_src_unpack
}

src_prepare() {
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"
	epatch "${FILESDIR}"/${PN}-3.4.9-calc_load_idle-aCOSwt_P3.patch
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
