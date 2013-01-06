# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libmthca/libmthca-1.0.5-r3.ebuild,v 1.1 2012/04/18 16:43:20 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="0.1.gbe5eef3"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox InfiniBand HCAs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"
block_other_ofed_versions
