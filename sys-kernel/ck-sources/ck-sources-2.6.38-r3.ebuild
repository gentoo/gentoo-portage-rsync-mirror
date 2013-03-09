# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-2.6.38-r3.ebuild,v 1.2 2013/03/09 21:07:32 tomwij Exp $

EAPI="5"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="Con Kolivas' high performance patchset + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/
	http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/"

CK_VERSION="3"
CK_REVISION=""
K_SECURITY_UNSUPPORTED="1"

if [[ -z "${CK_REVISION}" ]]; then
	CK_URI="mirror://kernel/linux/kernel/people/ck/patches/2.6/${PV}/${PV}-ck${CK_VERSION}/patch-${PV}-ck${CK_VERSION}.bz2"
	UNIPATCH_LIST="${DISTDIR}/patch-${PV}-ck${CK_VERSION}.bz2"
else
	# This is ck${CK_VERSION} but resynced to apply cleanly to stable kernel
	# release:
	CK_URI="mirror://gentoo/patch-${PV}-ck${CK_VERSION}-r${CK_REVISION}.bz2"
	UNIPATCH_LIST="${DISTDIR}/patch-${PV}-ck${CK_VERSION}-r${CK_REVISION}.bz2"
fi

UNIPATCH_STRICTORDER="yes"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_URI}"
IUSE=""
KEYWORDS="~amd64 ~x86"

src_unpack() {
	kernel-2_src_unpack

	# Comment out EXTRAVERSION added by CK patch:
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
