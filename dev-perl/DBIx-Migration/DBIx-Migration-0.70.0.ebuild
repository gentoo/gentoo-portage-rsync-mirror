# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Migration/DBIx-Migration-0.70.0.ebuild,v 1.2 2014/10/19 16:10:34 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DANIEL
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Seamless DB schema up- and downgrades"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/File-Slurp
	virtual/perl-File-Spec
	dev-perl/DBI
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/DBD-SQLite
	)"

SRC_TEST=do
