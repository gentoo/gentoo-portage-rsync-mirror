# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Socket/Socket-2.8.0.ebuild,v 1.1 2012/12/27 18:51:37 tove Exp $

EAPI=5

MODULE_AUTHOR=PEVANS
MODULE_VERSION=2.008
inherit perl-module

DESCRIPTION="Networking constants and support functions"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-ExtUtils-Constant-0.230.0
"

SRC_TEST="do"
