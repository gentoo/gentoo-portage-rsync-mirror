# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-3.7.9.ebuild,v 1.1 2013/02/23 18:27:58 hwoarang Exp $

EAPI="3"
ETYPE="sources"
KEYWORDS="~amd64 ~x86"
IUSE="bfsonly experimental urwlocks"

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

#-- If Gentoo-Sources don't follow then extra incremental patches are needed -

XTRA_INCP_MIN=""
XTRA_INCP_MAX=""

#--

CK_VERSION="1"
BFS_VERSION="426"

CK_FILE="patch-${K_BRANCH_ID}-ck${CK_VERSION}.bz2"
BFS_FILE="${K_BRANCH_ID}-sched-bfs-${BFS_VERSION}.patch"
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

#-- CK needs sometimes to patch itself... -------------------------------------

CK_INCP_URI="http://ck.kolivas.org/patches/bfs/3.0/3.7/3.7-bfs426-427.patch"
CK_INCP_LIST="${DISTDIR}/3.7-bfs426-427.patch"

#-- Local patches needed for the ck-patches to apply smoothly -----------------

PRE_CK_FIX=""
POST_CK_FIX=""

#--

SRC_URI="${KERNEL_URI} ${LX_INCP_URI} ${GENPATCHES_URI} ${ARCH_URI} ${CK_INCP_URI}
	!bfsonly? ( ${CK_URI} )
	bfsonly? ( ${BFS_URI} )
	experimental? (
		urwlocks? ( ${XPR_1_URI} ${XPR_2_URI} ) )"

UNIPATCH_LIST="${LX_INCP_LIST} ${PRE_CK_FIX} ${DISTDIR}"

if ! use bfsonly ; then
	UNIPATCH_LIST="${UNIPATCH_LIST}/${CK_FILE}"
else
	UNIPATCH_LIST="${UNIPATCH_LIST}/${BFS_FILE}"
fi

UNIPATCH_LIST="${UNIPATCH_LIST} ${CK_INCP_LIST} ${POST_CK_FIX}"

if use experimental ; then
	if use urwlocks ; then
		UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${XPR_1_FILE} ${DISTDIR}/${XPR_2_FILE}:1"
	fi
fi

UNIPATCH_STRICTORDER="yes"

src_prepare() {

#-- Comment out ck's EXTRAVERSION in Makefile ---------------------------------

	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"
}

pkg_postinst() {

	kernel-2_pkg_postinst

	ewarn ""
	ewarn "This release is concerned by numerous problems, non exhaustively :"
	ewarn " - No current x11-drivers/nvidia-driver officially support it."
	ewarn "   Their build against this release is likely to break! See https://bugs.gentoo.org/show_bug.cgi?id=447566"
	ewarn " - Known regressions concerning several USB peripherals including pcmcia and sound devices."
	ewarn "   See https://bugs.gentoo.org/show_bug.cgi?id=458600"
	ewarn " - The deblobbing fails to complete exhaustively. See https://bugs.gentoo.org/show_bug.cgi?id=458032"
	ewarn ""
	ewarn "You are aware that, depending on the parameters given to the emerge command which triggered the installation of this package,"
	ewarn "any future emerge --depclean might remove from your system the ck-sources < ${PVR} distributions."
	ewarn "If you decide not to keep this release, you are invited to add the following line to your package.mask file:"
	ewarn "=${CATEGORY}/${P}"

	elog
	elog "For more info on this patchset, see: http://forums.gentoo.org/viewtopic-t-941030-start-0.html"
	elog
}
