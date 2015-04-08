# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libical/libical-1.0-r2.ebuild,v 1.2 2014/05/07 02:41:12 patrick Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="An implementation of basic iCAL protocols from citadel, previously known as aurore"
HOMEPAGE="http://freeassociation.sourceforge.net"
SRC_URI="mirror://sourceforge/freeassociation/${PN}/${P}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0/1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc examples introspection static-libs"

RDEPEND="introspection? ( dev-libs/gobject-introspection )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_configure() {
	local mycmakeargs=" $( cmake-utils_use introspection GOBJECT_INTROSPECTION )"
	cmake-utils_src_configure
}

DOCS=(
	AUTHORS ChangeLog NEWS README TEST THANKS TODO
	doc/{AddingOrModifyingComponents,UsingLibical}.txt
)

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	cmake-utils_src_install

	# Remove static libs, cmake-flag is a trap.
	use static-libs || find "${ED}" -name '*.a' -delete

	if use examples; then
		rm examples/Makefile* examples/CMakeLists.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
