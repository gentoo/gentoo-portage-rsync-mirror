# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Factory-Util/Class-Factory-Util-1.700.0.ebuild,v 1.3 2012/09/01 11:18:57 grobian Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.7
inherit perl-module

DESCRIPTION="Provide utility methods for factory classes"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~ppc-aix ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"
