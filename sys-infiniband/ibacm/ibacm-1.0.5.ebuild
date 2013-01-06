# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/ibacm/ibacm-1.0.5.ebuild,v 1.1 2012/04/18 18:51:23 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="IB CM pre-connection service application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND="sys-infiniband/libibverbs:${SLOT}"
DEPEND="${RDEPEND}"
block_other_ofed_versions
