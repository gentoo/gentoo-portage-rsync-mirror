# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Search-Xapian/Search-Xapian-1.2.13.0.ebuild,v 1.4 2013/03/12 18:28:27 ago Exp $

EAPI="4"

MODULE_AUTHOR=OLLY
inherit perl-module toolchain-funcs versionator

VERSION=$(get_version_component_range 1-3)

SRC_URI+=" http://oligarchy.co.uk/xapian/${VERSION}/${P}.tar.gz"
DESCRIPTION="Perl XS frontend to the Xapian C++ search library."

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips ppc ~ppc64 x86"
IUSE="examples"

RDEPEND=">=dev-libs/xapian-1.2.9
	!dev-libs/xapian-bindings[perl]"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"

myconf="CXX=$(tc-getCXX) CXXFLAGS=${CXXFLAGS}"

src_install() {
	perl-module_src_install

	use examples && {
		docinto examples
		dodoc "${S}"/examples/*
	}
}
