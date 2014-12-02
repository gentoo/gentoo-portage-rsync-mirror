# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Warnings/Test-Warnings-0.16.0.ebuild,v 1.3 2014/12/02 09:06:49 jer Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=0.016
inherit perl-module

DESCRIPTION='Test for warnings and the lack of them'

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="test"

# Test::Builder -> perl-Test-Simple
RDEPEND="
	virtual/perl-Exporter
	virtual/perl-Test-Simple
	virtual/perl-parent
"
# File::Spec::Functions -> perl-File-Spec
# List::Util -> perl-Scalar-List-Utils
# Test::More -> perl-Test-Simple
DEPEND="
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	${RDEPEND}
	test? (
		virtual/perl-File-Spec
		virtual/perl-Scalar-List-Utils
		virtual/perl-Test-Simple
		virtual/perl-if
		virtual/perl-version
	)
"

SRC_TEST="do parallel"
