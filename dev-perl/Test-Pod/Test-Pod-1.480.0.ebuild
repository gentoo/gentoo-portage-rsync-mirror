# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Pod/Test-Pod-1.480.0.ebuild,v 1.12 2014/06/09 23:38:07 vapier Exp $

EAPI=5

MODULE_AUTHOR=DWHEELER
MODULE_VERSION=1.48
inherit perl-module

DESCRIPTION="check for POD errors in files"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/perl-Pod-Simple-3.50.0
	>=virtual/perl-Test-Simple-0.620.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.300.0
"

SRC_TEST="do"
