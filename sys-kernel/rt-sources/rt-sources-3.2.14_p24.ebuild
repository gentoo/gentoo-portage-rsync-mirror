# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rt-sources/rt-sources-3.2.14_p24.ebuild,v 1.2 2013/03/09 21:07:32 tomwij Exp $

EAPI="5"

inherit versionator

COMPRESSTYPE=".gz"
K_USEPV="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="yes"
K_DEBLOB_AVAILABLE="1"

CKV="$(get_version_component_range 1-3)"
ETYPE="sources"
inherit kernel-2
detect_version

RT_PATCHSET="${PV/*_p}"
RT_KERNEL="${PV/_p[0-9]*}"
RT_KERNEL="${RT_KERNEL/_/-}"
RT_FILE="patch-${RT_KERNEL}-rt${RT_PATCHSET}.patch${COMPRESSTYPE}"
RT_URI="mirror://kernel/linux/kernel/projects/rt/${KV_MAJOR}.${KV_MINOR}/${RT_FILE}"

DESCRIPTION="Real-time patchset for the Linux Kernel"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/projects/rt/"
SRC_URI="${KERNEL_URI} ${RT_URI}"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="deblob"

KV_FULL="${PVR/_p/-rt}"
EXTRAVERSION="-rt${RT_PATCHSET}"
S="${WORKDIR}/linux-${KV_FULL}"

pkg_setup(){
	ewarn
	ewarn "${PN} are *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the RT project developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds."
	ewarn
	kernel-2_pkg_setup
}

src_prepare(){
	epatch "${DISTDIR}"/"${RT_FILE}"
}

K_EXTRAEINFO="For more info on rt-sources and details on how to report problems, see: \
${HOMEPAGE}."
