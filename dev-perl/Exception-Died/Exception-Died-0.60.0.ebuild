# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Died/Exception-Died-0.60.0.ebuild,v 1.1 2011/08/31 10:37:49 tove Exp $

EAPI=4

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Convert simple die into real exception object"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/constant-boolean
	>=dev-perl/Exception-Base-0.22.01"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( virtual/perl-parent
#		>=dev-perl/Test-Unit-Lite-0.12
#		>=dev-perl/Test-Assert-0.0501 )"
