# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/autovivification/autovivification-0.130.0.ebuild,v 1.1 2014/10/07 21:59:21 mrueg Exp $
EAPI=5
MODULE_AUTHOR=VPIT
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Lexically disable autovivification"
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-XSLoader"
DEPEND="${RDEPEND}
	virtual/perl-Exporter
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Test-Simple"

SRC_TEST="do"
