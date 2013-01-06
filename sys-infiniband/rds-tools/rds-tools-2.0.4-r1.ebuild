# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/rds-tools/rds-tools-2.0.4-r1.ebuild,v 1.1 2012/04/18 16:46:19 alexxy Exp $

EAPI=4

OFED_VER="1.5.4.1"
OFED_SUFFIX="1"

inherit base openib toolchain-funcs

DESCRIPTION="OpenIB userspace rds-tools"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"
block_other_ofed_versions

DOCS=( README )
PATCHES=( "${FILESDIR}"/${P}-qa.patch )

pkg_setup() {
	tc-export CC
}
