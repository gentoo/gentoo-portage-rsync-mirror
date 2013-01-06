# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Socket/Socket-2.1.0.ebuild,v 1.1 2012/06/16 20:12:30 tove Exp $

EAPI=4

MODULE_AUTHOR=PEVANS
MODULE_VERSION=2.001
inherit perl-module

DESCRIPTION="Networking constants and support functions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-ExtUtils-Constant-0.230.0
"

SRC_TEST="do"
