# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract-Limit/SQL-Abstract-Limit-0.141.0-r1.ebuild,v 1.1 2014/10/26 15:48:35 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=DAVEBAIRD
MODULE_VERSION=0.141
inherit perl-module

DESCRIPTION="Portable LIMIT emulation"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/SQL-Abstract
	 dev-perl/DBI"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Deep
		dev-perl/Test-Exception
	)"

SRC_TEST=do
