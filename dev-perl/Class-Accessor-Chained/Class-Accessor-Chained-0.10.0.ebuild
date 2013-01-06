# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Chained/Class-Accessor-Chained-0.10.0.ebuild,v 1.3 2012/09/01 11:16:19 grobian Exp $

EAPI=4

MODULE_AUTHOR=RCLAMP
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Perl module to make chained class accessors"

SLOT="0"
KEYWORDS="amd64 x86 ~ppc-aix ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
