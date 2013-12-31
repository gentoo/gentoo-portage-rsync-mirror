# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cisco-Reconfig/Cisco-Reconfig-0.910.0.ebuild,v 1.2 2013/12/25 19:09:52 zlogene Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_VERSION=${PV%0.0}
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Parse and generate Cisco configuration files"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
