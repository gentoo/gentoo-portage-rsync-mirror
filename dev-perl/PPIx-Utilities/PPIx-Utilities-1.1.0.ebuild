# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Utilities/PPIx-Utilities-1.1.0.ebuild,v 1.3 2012/03/25 15:37:40 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ELLIOTJS
MODULE_VERSION=1.001000
inherit perl-module

DESCRIPTION="Extensions to PPI"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND=">=dev-perl/PPI-1.208
	dev-perl/Exception-Class
	dev-perl/Readonly
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep )"

SRC_TEST="do"
