# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-CheckDeps/Test-CheckDeps-0.10.0.ebuild,v 1.1 2014/10/19 21:37:27 zlogene Exp $

EAPI=5

MODULE_AUTHOR=LEONT
MODULE_VERSION=0.010
inherit perl-module

DESCRIPTION='Check for presence of dependencies'

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

# rdep Test::Builder -> perl-Test-Simple
RDEPEND="
	>=virtual/perl-CPAN-Meta-2.120.920
	>=dev-perl/CPAN-Meta-Check-0.7.0
	>=virtual/perl-Exporter-5.570.0
	virtual/perl-Scalar-List-Utils
	virtual/perl-Test-Simple
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		virtual/perl-File-Spec
		>=virtual/perl-Test-Simple-0.880.0
	)
"

SRC_TEST="do"
