# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.450.0.ebuild,v 1.3 2012/04/28 02:42:52 aballier Exp $

EAPI=3

MODULE_AUTHOR=DWHEELER
MODULE_VERSION=1.45
inherit perl-module

DESCRIPTION="check for POD errors in files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Pod-Simple-3.05
	>=virtual/perl-Test-Simple-0.62"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.30"

SRC_TEST="do"
