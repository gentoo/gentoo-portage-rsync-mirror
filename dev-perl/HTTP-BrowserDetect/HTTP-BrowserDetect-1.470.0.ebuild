# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.470.0.ebuild,v 1.3 2013/03/25 20:48:31 ago Exp $

EAPI=4

MODULE_AUTHOR=OALDERS
MODULE_VERSION=1.47
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="
	virtual/perl-Module-Build
	test? (
		dev-perl/File-Slurp
		virtual/perl-JSON-PP
		dev-perl/Test-NoWarnings
	)
"

SRC_TEST="do"
