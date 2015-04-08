# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.967.9-r1.ebuild,v 1.1 2014/08/22 16:48:49 axs Exp $

EAPI=5

MODULE_AUTHOR=JTBRAUN
MODULE_VERSION=1.967009
inherit perl-module

DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=virtual/perl-Text-Balanced-1.950.0
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Warn
	)
"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	dohtml -r tutorial || die
}
