# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-FailWarnings/Test-FailWarnings-0.8.0.ebuild,v 1.1 2014/11/30 00:11:05 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.008
inherit perl-module

DESCRIPTION="Add test failures if warnings are caught"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
LICENSE="Apache-2.0"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-File-Spec
	>=virtual/perl-Test-Simple-0.860.0
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=dev-perl/Capture-Tiny-0.120.0
		virtual/perl-File-Spec
		virtual/perl-File-Temp
		virtual/perl-IO
		virtual/perl-Scalar-List-Utils
		>=virtual/perl-Test-Simple-0.960.0
	)
"
