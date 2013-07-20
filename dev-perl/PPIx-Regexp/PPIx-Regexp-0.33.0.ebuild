# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Regexp/PPIx-Regexp-0.33.0.ebuild,v 1.2 2013/07/20 11:39:10 zlogene Exp $

EAPI=5

MODULE_AUTHOR=WYANT
MODULE_VERSION=0.033
inherit perl-module

DESCRIPTION="Represent a regular expression of some sort"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="
	dev-perl/List-MoreUtils
	dev-perl/PPI
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST=do
