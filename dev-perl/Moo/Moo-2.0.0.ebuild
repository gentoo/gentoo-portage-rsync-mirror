# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moo/Moo-2.0.0.ebuild,v 1.3 2015/04/02 10:22:32 zlogene Exp $

EAPI=5

MODULE_AUTHOR=HAARG
MODULE_VERSION=2.000000
inherit perl-module

DESCRIPTION="Minimalist Object Orientation (with Moose compatiblity)"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Method-Modifiers-1.100.0
	>=dev-perl/Devel-GlobalDestruction-0.110.0
	>=virtual/perl-Exporter-5.570.0
	>=dev-perl/Module-Runtime-0.14.0
	>=dev-perl/Role-Tiny-2.0.0
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=dev-perl/Test-Fatal-0.3.0
		>=virtual/perl-Test-Simple-0.94
	)
"

SRC_TEST="do parallel"
