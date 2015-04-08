# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-ScanDeps/Module-ScanDeps-1.120.0.ebuild,v 1.5 2014/08/31 16:17:02 zlogene Exp $

EAPI=5

MODULE_AUTHOR=RSCHUPP
MODULE_VERSION=1.12
inherit perl-module

DESCRIPTION="Recursively scan Perl code for dependencies"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"

RDEPEND="virtual/perl-Module-Build
	virtual/perl-version"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/prefork
		virtual/perl-Module-Pluggable
		dev-perl/Test-Requires )"

SRC_TEST=do
