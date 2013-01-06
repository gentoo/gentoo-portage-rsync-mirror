# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Warn/Test-Warn-0.230.0.ebuild,v 1.10 2012/06/17 13:51:35 armin76 Exp $

EAPI=3

MODULE_AUTHOR=CHORNY
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="Perl extension to test methods for warnings"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Sub-Uplevel-0.12
	dev-perl/Tree-DAG_Node
	virtual/perl-Test-Simple
	virtual/perl-File-Spec"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod )"

SRC_TEST="do"
