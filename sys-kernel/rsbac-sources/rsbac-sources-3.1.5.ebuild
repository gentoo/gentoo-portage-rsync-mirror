# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-3.1.5.ebuild,v 1.1 2012/01/07 20:25:49 blueness Exp $

EAPI="4"

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="8"

inherit kernel-2
detect_version

HGPV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}-1"
HGPV_URI="http://dev.gentoo.org/~blueness/hardened-sources/hardened-patches/rsbac-patches-${HGPV}.extras.tar.bz2"
SRC_URI="${KERNEL_URI} ${HGPV_URI} ${GENPATCHES_URI} ${ARCH_URI}"

UNIPATCH_LIST="${DISTDIR}/rsbac-patches-${HGPV}.extras.tar.bz2"
UNIPATCH_EXCLUDE="4200_fbcondecor-0.9.6.patch"

DESCRIPTION="Hardened + RSBAC kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"
IUSE=""

KEYWORDS="~amd64 ~x86"
