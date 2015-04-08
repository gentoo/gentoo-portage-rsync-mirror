# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Build-XSUtil/Module-Build-XSUtil-0.140.0.ebuild,v 1.3 2014/11/29 10:10:03 zlogene Exp $

EAPI=5

MODULE_AUTHOR="HIDEAKIO"
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="A Module::Build class for building XS modules"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="test"
# File::Basename -> perl
RDEPEND="
	>=dev-perl/Devel-CheckCompiler-0.20.0
	>=virtual/perl-Devel-PPPort-3.190.0
	virtual/perl-Exporter
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-File-Path
	>=virtual/perl-XSLoader-0.20.0
	virtual/perl-parent
"
# File::Spec::Functions -> virtual/perl-File-Spec
# Test::More -> perl-Test-Simple
DEPEND="
	>=virtual/perl-Module-Build-0.400.500
	${RDEPEND}
	test? (
		dev-perl/Capture-Tiny
		dev-perl/Cwd-Guard
		dev-perl/File-Copy-Recursive
		virtual/perl-File-Spec
		virtual/perl-File-Temp
		>=virtual/perl-Test-Simple-0.980.0
	)
"
SRC_TEST="do parallel"
