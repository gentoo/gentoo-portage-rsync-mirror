# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Distribution/Test-Distribution-2.0.0.ebuild,v 1.6 2014/01/30 23:12:36 maekke Exp $

EAPI=4

MODULE_AUTHOR=SRSHAH
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="perform tests on all modules of a distribution"

SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-perl/Pod-Coverage-0.20
	>=dev-perl/File-Find-Rule-0.30
	dev-perl/Test-Pod-Coverage
	>=virtual/perl-Module-CoreList-2.17
	>=dev-perl/Test-Pod-1.26"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
