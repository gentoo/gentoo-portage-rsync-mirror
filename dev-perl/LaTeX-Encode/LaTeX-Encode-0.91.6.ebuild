# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LaTeX-Encode/LaTeX-Encode-0.91.6.ebuild,v 1.2 2014/10/23 19:41:24 maekke Exp $

EAPI=5

MODULE_AUTHOR=EINHVERFR
MODULE_VERSION=0.091.6
inherit perl-module

DESCRIPTION="Encode characters for LaTeX formatting"

LICENSE="|| ( GPL-1+ Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Getopt-Long
	dev-perl/HTML-Parser
	dev-perl/Pod-LaTeX
	dev-perl/Readonly
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

SRC_TEST="do"
