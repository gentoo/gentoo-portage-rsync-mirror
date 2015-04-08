# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-3.10.63.ebuild,v 1.1 2015/01/19 06:23:22 dlan Exp $

EAPI="5"
ETYPE="sources"
KEYWORDS="~amd64 ~x86"
IUSE="bfsonly"

HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/
	http://users.on.net/~ckolivas/kernel/"

K_WANT_GENPATCHES="base extras experimental"
K_EXP_GENPATCHES_PULL="1"
K_EXP_GENPATCHES_NOUSE="1"
K_GENPATCHES_VER="70"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version
detect_arch

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"

DESCRIPTION="Full Linux ${K_BRANCH_ID} kernel sources with Con Kolivas' high performance patchset and Gentoo's genpatches"

#-- If Gentoo-Sources don't follow then extra incremental patches are needed -

XTRA_INCP_MIN=""
XTRA_INCP_MAX=""

#--

CK_VERSION="1"
BFS_VERSION="440"

CK_FILE="patch-${K_BRANCH_ID}-ck${CK_VERSION}-r1.bz2"
BFS_FILE="${K_BRANCH_ID}-sched-bfs-${BFS_VERSION}-r1.patch"

CK_BASE_URL="http://ck.kolivas.org/patches/3.0"
CK_LVER_URL="${CK_BASE_URL}/${K_BRANCH_ID}/${K_BRANCH_ID}-ck${CK_VERSION}"
CK_URI="http://dev.gentoo.org/~dlan/distfiles/${CK_FILE}
	${CK_LVER_URL}/${CK_FILE}"
BFS_URI="http://dev.gentoo.org/~dlan/distfiles/${BFS_FILE}
	${CK_LVER_URL}/patches/${BFS_FILE}"

#-- Build extra incremental patches list --------------------------------------

LX_INCP_URI=""
LX_INCP_LIST=""
if [ -n "${XTRA_INCP_MIN}" ]; then
	LX_INCP_URL="${KERNEL_BASE_URI}/incr"
	for i in `seq ${XTRA_INCP_MIN} ${XTRA_INCP_MAX}`; do
		LX_INCP[i]="patch-${K_BRANCH_ID}.${i}-$(($i+1)).bz2"
		LX_INCP_URI="${LX_INCP_URI} ${LX_INCP_URL}/${LX_INCP[i]}"
		LX_INCP_LIST="${LX_INCP_LIST} ${DISTDIR}/${LX_INCP[i]}"
	done
fi

#-- CK needs sometimes to patch itself... (3.7)--------------------------------

CK_INCP_URI=""
CK_INCP_LIST=""

#-- Local patches needed for the ck-patches to apply smoothly (3.4/3.5) -------

PRE_CK_FIX=""
POST_CK_FIX=""

#--

SRC_URI="${KERNEL_URI} ${LX_INCP_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_INCP_URI}
	!bfsonly? ( ${CK_URI} )
	bfsonly? ( ${BFS_URI} )"

UNIPATCH_LIST="${LX_INCP_LIST} ${PRE_CK_FIX} ${DISTDIR}"

if ! use bfsonly ; then
	UNIPATCH_LIST="${UNIPATCH_LIST}/${CK_FILE}"
else
	UNIPATCH_LIST="${UNIPATCH_LIST}/${BFS_FILE}"
fi

UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_INCP_LIST} ${POST_CK_FIX}"

UNIPATCH_STRICTORDER="yes"

#-- Since experimental genpatches && we want BFQ irrespective of experimental -

K_EXP_GENPATCHES_LIST="50*_*.patch*"

src_prepare() {

#-- Comment out CK's EXTRAVERSION in Makefile ---------------------------------

	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"
}

pkg_postinst() {

	kernel-2_pkg_postinst

	elog
	elog "For more info on this patchset, see: http://forums.gentoo.org/viewtopic-t-941030-start-0.html"
	elog
}
