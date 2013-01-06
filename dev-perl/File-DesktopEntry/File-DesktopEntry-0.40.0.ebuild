# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.40.0.ebuild,v 1.5 2012/05/06 00:35:49 aballier Exp $

EAPI=4

MODULE_AUTHOR=PARDUS
MODULE_VERSION=0.04
MODULE_SECTION=File-DesktopEntry
inherit perl-module

DESCRIPTION="Object to handle .desktop files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
