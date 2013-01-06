# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/mstflint/mstflint-1.4.ebuild,v 1.1 2012/04/18 18:59:45 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1.18.g1adcfbf"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="Mellanox firmware burning application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"
block_other_ofed_versions
