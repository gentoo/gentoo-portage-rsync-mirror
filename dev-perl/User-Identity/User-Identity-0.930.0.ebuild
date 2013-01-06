# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/User-Identity/User-Identity-0.930.0.ebuild,v 1.3 2012/06/26 12:18:52 ago Exp $

EAPI=4

MODULE_AUTHOR=MARKOV
MODULE_VERSION=0.93
inherit perl-module

DESCRIPTION="Maintains info about a physical person"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="
"
#	dev-perl/TimeDate
#	dev-perl/Geography-Countries
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Pod-1.0.0
	)
"

SRC_TEST=do
