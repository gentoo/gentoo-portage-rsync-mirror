# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.965.1.ebuild,v 1.2 2011/04/24 15:31:04 grobian Exp $

EAPI=3

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=1.965001
inherit perl-module

DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="virtual/perl-Text-Balanced
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	dohtml -r tutorial || die
}
