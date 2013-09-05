# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/B-Debug/B-Debug-1.180.0.ebuild,v 1.1 2013/09/05 05:16:24 patrick Exp $
EAPI=4
MODULE_AUTHOR=RURBAN
MODULE_VERSION=1.18
inherit perl-module

DESCRIPTION='print debug info about ops'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Test-Simple
	"
RDEPEND="
	virtual/perl-Test-Simple
	"
SRC_TEST="do"
