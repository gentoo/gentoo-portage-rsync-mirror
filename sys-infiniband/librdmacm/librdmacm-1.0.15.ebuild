# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/librdmacm/librdmacm-1.0.15.ebuild,v 1.1 2012/04/18 16:44:09 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit eutils openib

DESCRIPTION="OpenIB userspace RDMA CM library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"
block_other_ofed_versions
