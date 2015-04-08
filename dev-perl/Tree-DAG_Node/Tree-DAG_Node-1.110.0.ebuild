# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-DAG_Node/Tree-DAG_Node-1.110.0.ebuild,v 1.2 2014/06/09 23:39:35 vapier Exp $

EAPI=5

MODULE_AUTHOR=RSAVAGE
MODULE_A_EXT=tgz
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="(Super)class for representing nodes in a tree"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

DEPEND="
	>=virtual/perl-Module-Build-0.380.0
	test? (
		>=dev-perl/Test-Pod-1.450.0
		>=virtual/perl-Test-Simple-0.980.0
	)
"

SRC_TEST="do"
