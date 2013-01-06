# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-XPath/Class-XPath-1.400.0.ebuild,v 1.2 2011/09/03 21:04:58 tove Exp $

EAPI=4

MODULE_AUTHOR=SAMTREGAR
MODULE_VERSION=1.4
inherit perl-module

DESCRIPTION="adds xpath matching to object trees"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/HTML-Tree )"

SRC_TEST="do"
