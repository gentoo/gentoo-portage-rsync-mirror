# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppunit/cppunit-1.13.0.ebuild,v 1.9 2013/06/17 07:38:23 pinkbyte Exp $

EAPI=4

inherit eutils flag-o-matic

DESCRIPTION="C++ port of the famous JUnit framework for unit testing"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/cppunit"
SRC_URI="http://dev-www.libreoffice.org/src/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
		media-gfx/graphviz
	)"

DOCS=( AUTHORS ChangeLog BUGS NEWS README THANKS TODO doc/FAQ )

src_configure() {
	# Anything else than -O0 breaks on alpha
	use alpha && replace-flags "-O?" -O0

	econf \
		$(use_enable static-libs static) \
		$(use_enable doc doxygen) \
		$(use_enable doc dot) \
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--disable-silent-rules
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +

	if use examples ; then
		find examples -iname "*.o" -delete
		insinto /usr/share/${PN}
		doins -r examples
	fi
}
