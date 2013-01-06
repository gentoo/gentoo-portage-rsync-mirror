# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibverbs/libibverbs-1.1.4-r1.ebuild,v 1.1 2012/04/18 16:42:08 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="1.24.gb89d4d7"
OFED_SNAPSHOT="1"

inherit eutils openib

DESCRIPTION="A library allowing programs to use InfiniBand 'verbs' for direct access to IB hardware"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!sys-infiniband/openib-userspace"
block_other_ofed_versions
