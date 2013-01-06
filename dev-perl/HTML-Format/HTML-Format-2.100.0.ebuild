# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Format/HTML-Format-2.100.0.ebuild,v 1.5 2012/03/25 15:22:55 armin76 Exp $

EAPI=4

MODULE_AUTHOR=NIGELM
MODULE_VERSION=2.10
inherit perl-module

DESCRIPTION="HTML Formatter"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

RDEPEND="
	dev-perl/File-Slurp
	dev-perl/Font-AFM
	dev-perl/HTML-Tree"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		>=virtual/perl-Test-Simple-0.96
	)"

SRC_TEST="do"
