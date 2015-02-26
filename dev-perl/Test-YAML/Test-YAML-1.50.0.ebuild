# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-YAML/Test-YAML-1.50.0.ebuild,v 1.1 2015/02/25 23:39:03 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=INGY
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Testing Module for YAML Implementations"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~s390 ~sh ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=dev-perl/Test-Base-0.860.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
"
