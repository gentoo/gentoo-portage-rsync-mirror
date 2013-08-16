# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CryptX/CryptX-0.012.ebuild,v 1.1 2013/08/16 07:45:59 patrick Exp $

EAPI="5"
MODULE_AUTHOR="MIK"

inherit perl-module

DESCRIPTION="Self-contained crypto toolkit"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-Module-Build"
