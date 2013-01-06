# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-3.6.11.ebuild,v 1.1 2012/12/19 17:14:13 hwoarang Exp $

EAPI="3"
ETYPE="sources"
KEYWORDS="~amd64 ~x86"
IUSE="bfsonly experimental kvm urwlocks"

HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/
	http://users.on.net/~ckolivas/kernel/"

K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="11"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2
detect_version
detect_arch

K_BRANCH_ID="${KV_MAJOR}.${KV_MINOR}"

DESCRIPTION="Full Linux ${K_BRANCH_ID} kernel sources with Con Kolivas' high performance patchset and Gentoo's genpatches."

#-- If Gentoo-Sources don't follow then extra incremental patches are needed ---

XTRA_INCP_MIN=""
XTRA_INCP_MAX=""

#--

CK_VERSION="1"
BFS_VERSION="425"

CK_FILE="patch-${K_BRANCH_ID}-ck${CK_VERSION}.bz2"
BFS_FILE="${K_BRANCH_ID}-sched-bfs-${BFS_VERSION}.patch"

#-- CK messed-up 3.6 branch filenames ----------------------------------------

BFS_FILE="3.5-sched-bfs-${BFS_VERSION}.patch"

#--

XPR_1_FILE="bfs${BFS_VERSION}-grq_urwlocks.patch"
XPR_2_FILE="urw-locks.patch"

CK_BASE_URL="http://ck.kolivas.org/patches/3.0"
CK_LVER_URL="${CK_BASE_URL}/${K_BRANCH_ID}/${K_BRANCH_ID}-ck${CK_VERSION}"
CK_URI="${CK_LVER_URL}/${CK_FILE}"
BFS_URI="${CK_LVER_URL}/patches/${BFS_FILE}"
XPR_1_URI="${CK_LVER_URL}/patches/${XPR_1_FILE}"
XPR_2_URI="${CK_LVER_URL}/patches/${XPR_2_FILE}"

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

#--

#-- Local patches needed for the ck-patches to apply smoothly -----------------

PRE_CK_FIX=""
POST_CK_FIX=""

#--

SRC_URI="${KERNEL_URI} ${LX_INCP_URI} ${GENPATCHES_URI} ${ARCH_URI}
	!bfsonly? ( ${CK_URI} )
	bfsonly? ( ${BFS_URI} )
	experimental? (
		urwlocks? ( ${XPR_1_URI} ${XPR_2_URI} ) )"

if ! use bfsonly ; then
	UNIPATCH_LIST="${LX_INCP_LIST} ${PRE_CK_FIX} ${DISTDIR}/${CK_FILE} ${POST_CK_FIX}"
else
	UNIPATCH_LIST="${LX_INCP_LIST} ${PRE_CK_FIX} ${DISTDIR}/${BFS_FILE} ${POST_CK_FIX}"
fi

if use experimental ; then
	if use urwlocks ; then
		UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${XPR_1_FILE} ${DISTDIR}/${XPR_2_FILE}:1"
	fi
fi

if use kvm ; then
	UNIPATCH_LIST="${UNIPATCH_LIST} ${FILESDIR}/${PN}-3.6-Fix_Boot_Issue_On_Kvm-aCOSwt_P6.patch"
fi

UNIPATCH_STRICTORDER="yes"

src_unpack() {
	kernel-2_src_unpack
}

src_prepare() {

#-- Comment out ck's EXTRAVERSION in Makefile ---------------------------------

	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"

#--
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, see: http://forums.gentoo.org/viewtopic-t-941030-start-0.html"
}
