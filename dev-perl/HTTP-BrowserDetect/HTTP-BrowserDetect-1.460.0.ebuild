# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-1.460.0.ebuild,v 1.1 2012/12/08 11:56:13 tove Exp $

EAPI=4

MODULE_AUTHOR=OALDERS
MODULE_VERSION=1.46
inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
	virtual/perl-Module-Build
	test? (
		dev-perl/File-Slurp
		virtual/perl-JSON-PP
	)
"

SRC_TEST="do"
