# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cisco-Reconfig/Cisco-Reconfig-0.900.0.ebuild,v 1.2 2011/09/03 21:04:56 tove Exp $

EAPI=4

MODULE_AUTHOR=MUIR
MODULE_VERSION=0.9
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Parse and generate Cisco configuration files"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"
