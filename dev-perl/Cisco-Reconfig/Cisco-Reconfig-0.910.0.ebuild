# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cisco-Reconfig/Cisco-Reconfig-0.910.0.ebuild,v 1.1 2012/02/29 08:58:18 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_VERSION=${PV%0.0}
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Parse and generate Cisco configuration files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
