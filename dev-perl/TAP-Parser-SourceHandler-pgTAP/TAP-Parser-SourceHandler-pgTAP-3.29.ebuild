# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TAP-Parser-SourceHandler-pgTAP/TAP-Parser-SourceHandler-pgTAP-3.29.ebuild,v 1.2 2013/05/01 10:31:48 ago Exp $

EAPI=5

MODULE_AUTHOR=DWHEELER
MODULE_VERSION=3.29
inherit perl-module

DESCRIPTION="Stream TAP from pgTAP test scripts"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="virtual/perl-Test-Harness"
DEPEND="${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		virtual/perl-Module-Build
"

SRC_TEST="do"
