# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libcxgb4/libcxgb4-1.2.0.ebuild,v 1.1 2012/04/18 16:40:23 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB - driver for Chelsio T4-based iWARP (RDMA over IP/ethernet)"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}"
RDEPEND="${DEPEND}"
block_other_ofed_versions
