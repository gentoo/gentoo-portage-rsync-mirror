# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libsdp/libsdp-1.1.108-r1.ebuild,v 1.1 2012/04/18 16:44:34 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="0.17.ga6958ef"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="Socket Direct Protocol for unmodified applications"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibverbs:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
