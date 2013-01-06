# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/cairomm/cairomm-1.8.6.ebuild,v 1.7 2011/03/22 19:58:50 ranger Exp $

EAPI="3"

inherit eutils

DESCRIPTION="C++ bindings for the Cairo vector graphics library"
HOMEPAGE="http://cairographics.org/cairomm"
SRC_URI="http://cairographics.org/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc svg"

# FIXME: svg support is automagic
RDEPEND=">=x11-libs/cairo-1.8[svg?]
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	# don't waste time building examples because they are marked as "noinst"
	sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || die "sed failed"

	# don't waste time building tests
	# they require the boost Unit Testing framework, that's not in base boost
	sed -i 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' Makefile.in || die "sed failed"
}

src_configure() {
	econf \
		--disable-tests  \
		$(use_enable doc documentation)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README ChangeLog || die "dodoc failed"
}
