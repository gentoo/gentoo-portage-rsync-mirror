# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ck-sources/ck-sources-3.5.7-r1.ebuild,v 1.1 2012/10/29 20:48:04 hwoarang Exp $

EAPI="3"
ETYPE="sources"

DESCRIPTION="Con Kolivas' high performance patchset + Gentoo patchset sources"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches/
	http://users.on.net/~ckolivas/kernel/"

KEYWORDS="~amd64 ~x86"

K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="7"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"

inherit kernel-2 versionator
detect_version
detect_arch

BASE_VERSION="$(get_version_component_range 1-2)"
CK_VERSION="1"
BFS_VERSION="424"

CK_FILE="patch-${BASE_VERSION}-ck${CK_VERSION}.bz2"
BFS_FILE="${BASE_VERSION}-sched-bfs-${BFS_VERSION}.patch"
XPR_1_FILE="bfs${BFS_VERSION}-grq_urwlocks.patch"
XPR_2_FILE="urw-locks.patch"

CK_BASE_URL="http://ck.kolivas.org/patches/3.0"
CK_URI="${CK_BASE_URL}/${BASE_VERSION}/${BASE_VERSION}-ck${CK_VERSION}/${CK_FILE}"
BFS_URI="${CK_BASE_URL}/${BASE_VERSION}/${BASE_VERSION}-ck${CK_VERSION}/patches/${BFS_FILE}"
XPR_1_URI="${CK_BASE_URL}/${BASE_VERSION}/${BASE_VERSION}-ck${CK_VERSION}/patches/${XPR_1_FILE}"
XPR_2_URI="${CK_BASE_URL}/${BASE_VERSION}/${BASE_VERSION}-ck${CK_VERSION}/patches/${XPR_2_FILE}"

UNIPATCH_STRICTORDER="yes"

IUSE="bfsonly deblob experimental urwlocks"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}
	!bfsonly? ( ${CK_URI} )
	bfsonly? ( ${BFS_URI} )
	experimental? (
		urwlocks? ( ${XPR_1_URI} ${XPR_2_URI} ) )"

PRE_CK_FIX="${FILESDIR}/ck-sources-3.4-3.5-PreCK-Sched_Fix_Race_In_Task_Group-aCOSwt_P4.patch"
POST_CK_FIX="${FILESDIR}/ck-sources-3.4-3.5-PostCK-Sched_Fix_Race_In_Task_Group-aCOSwt_P5.patch"

if ! use bfsonly ; then
	UNIPATCH_LIST="${PRE_CK_FIX} ${DISTDIR}/${CK_FILE} ${POST_CK_FIX}"
else
	UNIPATCH_LIST="${PRE_CK_FIX} ${DISTDIR}/${BFS_FILE} ${POST_CK_FIX}"
fi
if use experimental ; then
	if use urwlocks ; then
		UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${XPR_1_FILE} ${DISTDIR}/${XPR_2_FILE}"
	fi
fi
src_unpack() {
	kernel-2_src_unpack
}

src_prepare() {
# Working around BUG 436424
	if use experimental ; then
		if use urwlocks ; then
			mv "${S}/linux-3.5.2-bfs/include/linux/urwlock.h" "${S}/include/linux/urwlock.h"
		fi
	fi
# Comment out EXTRAVERSION added by CK patch:
	sed -i -e 's/\(^EXTRAVERSION :=.*$\)/# \1/' "${S}/Makefile"
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
