# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Classify/Params-Classify-0.13.0.ebuild,v 1.6 2012/04/01 15:50:35 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.013
inherit perl-module

DESCRIPTION="Argument type classification"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sh ~sparc ~x86 ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.10.0
	virtual/perl-XSLoader
	virtual/perl-parent
"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
	>=virtual/perl-ExtUtils-CBuilder-0.150.0
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
