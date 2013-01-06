# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/infiniband-diags/infiniband-diags-1.5.13.ebuild,v 1.1 2012/04/18 16:39:13 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB diagnostic programs and scripts needed to diagnose an IB subnet"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibumad:${SLOT}
	sys-infiniband/libibmad:${SLOT}
	sys-infiniband/opensm:${SLOT}"
RDEPEND="${DEPEND}"
block_other_ofed_versions
