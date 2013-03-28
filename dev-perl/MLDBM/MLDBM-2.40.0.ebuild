# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.40.0.ebuild,v 1.6 2013/03/28 22:47:22 ago Exp $

EAPI=4

MODULE_AUTHOR=CHORNY
MODULE_VERSION=2.04
inherit perl-module

DESCRIPTION="A multidimensional/tied hash Perl Module"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ia64 ppc ppc64 ~s390 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
