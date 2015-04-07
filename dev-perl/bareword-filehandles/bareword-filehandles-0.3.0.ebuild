# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/bareword-filehandles/bareword-filehandles-0.3.0.ebuild,v 1.1 2015/04/06 23:01:19 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=ILMARI
MODULE_VERSION=0.003
inherit perl-module

DESCRIPTION="Disables bareword filehandles"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/B-Hooks-OP-Check
	dev-perl/Lexical-SealRequireHints
	virtual/perl-XSLoader
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
	dev-perl/extutils-depends
	test? ( >=virtual/perl-Test-Simple-0.880.0 )
"

SRC_TEST=do
