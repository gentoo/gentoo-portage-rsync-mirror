# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-System/Exception-System-0.110.0-r1.ebuild,v 1.1 2014/08/26 18:39:18 axs Exp $

EAPI=5

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Exception class for system or library calls"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Exception-Base-0.22.01"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Unit-Lite-0.12 )"

SRC_TEST=do
