# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Install/Module-Install-1.120.0.ebuild,v 1.2 2014/10/01 11:36:06 zlogene Exp $

EAPI=5

MODULE_AUTHOR=BINGOS
MODULE_VERSION=1.12
inherit perl-module

DESCRIPTION="Standalone, extensible Perl module installer"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="test"

RDEPEND=">=virtual/perl-File-Spec-3.28
	>=virtual/perl-Archive-Tar-1.44
	>=virtual/perl-ExtUtils-MakeMaker-6.590.0
	>=virtual/perl-ExtUtils-ParseXS-2.19
	>=virtual/perl-Module-Build-0.33
	>=virtual/perl-Module-CoreList-2.17
	>=virtual/perl-Parse-CPAN-Meta-1.39
	>=dev-perl/libwww-perl-5.812
	>=dev-perl/File-Remove-1.42
	>=dev-perl/JSON-2.14
	>=dev-perl/Module-ScanDeps-0.89
	>=dev-perl/PAR-Dist-0.29
	>=dev-perl/YAML-Tiny-1.38"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Harness-3.13
		>=virtual/perl-Test-Simple-0.86 )"

SRC_TEST=do
