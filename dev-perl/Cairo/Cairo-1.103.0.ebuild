# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cairo/Cairo-1.103.0.ebuild,v 1.10 2014/04/18 17:37:19 zlogene Exp $

EAPI=5

MODULE_AUTHOR=XAOC
MODULE_VERSION=1.103
inherit perl-module

DESCRIPTION="Perl interface to the cairo library"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

RDEPEND="
	>=x11-libs/cairo-1.0.0
"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205.0
	>=dev-perl/extutils-pkgconfig-1.70.0
	test? (
		dev-perl/Test-Number-Delta
	)
"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	sed -i -e 's,exit 0,exit 1,' "${S}"/Makefile.PL || die
}
