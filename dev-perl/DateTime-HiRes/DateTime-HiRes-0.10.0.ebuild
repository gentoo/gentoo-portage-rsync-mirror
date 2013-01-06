# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-HiRes/DateTime-HiRes-0.10.0.ebuild,v 1.1 2011/08/31 12:30:54 tove Exp $

EAPI=4

MODULE_AUTHOR=JHOBLITT
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Create DateTime objects with sub-second current time resolution"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
