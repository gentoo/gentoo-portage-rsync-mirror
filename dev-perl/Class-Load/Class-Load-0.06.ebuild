# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load/Class-Load-0.06.ebuild,v 1.9 2012/08/07 21:14:21 ranger Exp $

EAPI=3

MODULE_AUTHOR=SARTAK
inherit perl-module

DESCRIPTION="a working (require q{Class::Name}) and more "

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Fatal
	)"

SRC_TEST="do"
