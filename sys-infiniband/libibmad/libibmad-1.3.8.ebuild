# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibmad/libibmad-1.3.8.ebuild,v 1.1 2012/04/18 16:41:19 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB library providing low layer IB functions for use by the IB diagnostic/management programs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibumad:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
