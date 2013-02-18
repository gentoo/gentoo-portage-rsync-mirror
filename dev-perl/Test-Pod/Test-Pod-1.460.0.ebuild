# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.460.0.ebuild,v 1.1 2013/02/18 19:10:28 tove Exp $

EAPI=5

MODULE_AUTHOR=DWHEELER
MODULE_VERSION=1.46
inherit perl-module

DESCRIPTION="check for POD errors in files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/perl-Pod-Simple-3.50.0
	>=virtual/perl-Test-Simple-0.620.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.300.0
"

SRC_TEST="do"
