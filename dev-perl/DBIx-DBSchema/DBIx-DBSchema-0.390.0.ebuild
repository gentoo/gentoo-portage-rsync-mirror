# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-DBSchema/DBIx-DBSchema-0.390.0.ebuild,v 1.4 2012/09/30 18:19:50 armin76 Exp $

EAPI=4

MODULE_AUTHOR=IVAN
MODULE_VERSION=0.39
inherit perl-module

DESCRIPTION="Database-independent schema objects"

SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

RDEPEND="dev-perl/DBI
	dev-perl/FreezeThaw
	virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
