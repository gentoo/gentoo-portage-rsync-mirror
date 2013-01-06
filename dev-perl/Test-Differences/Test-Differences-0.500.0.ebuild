# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Differences/Test-Differences-0.500.0.ebuild,v 1.3 2012/03/18 18:25:08 armin76 Exp $

EAPI=4

MODULE_AUTHOR=OVID
MODULE_VERSION=0.500
inherit perl-module

DESCRIPTION="Test strings and data structures and show differences if not ok"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="dev-perl/Text-Diff"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
