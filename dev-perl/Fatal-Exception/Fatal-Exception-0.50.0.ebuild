# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Fatal-Exception/Fatal-Exception-0.50.0.ebuild,v 1.1 2011/08/31 10:13:10 tove Exp $

EAPI=4

MODULE_AUTHOR=DEXTER
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Succeed or throw exception"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Exception-Died
	>=dev-perl/Exception-Base-0.22.01"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( >=dev-perl/Test-Unit-Lite-0.12
#		dev-perl/Test-Assert
#		dev-perl/Exception-Warning )"
