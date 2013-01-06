# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-W3CDTF/DateTime-Format-W3CDTF-0.60.0.ebuild,v 1.7 2012/03/19 19:46:57 armin76 Exp $

EAPI=4

MODULE_AUTHOR=GWILLIAMS
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Parse and format W3CDTF datetime strings"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
