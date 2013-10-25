# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Socket/Socket-2.9.0.ebuild,v 1.2 2013/10/25 14:06:58 jer Exp $

EAPI=5

MODULE_AUTHOR=PEVANS
MODULE_VERSION=2.009
inherit perl-module

DESCRIPTION="Networking constants and support functions"

SLOT="0"
KEYWORDS="~amd64 hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-ExtUtils-CBuilder
	>=virtual/perl-ExtUtils-Constant-0.230.0
"

SRC_TEST="do"
