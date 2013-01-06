# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-2.24.2.ebuild,v 1.10 2012/12/09 22:23:58 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ interface for GTK+"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1+"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="doc examples test"

RDEPEND=">=dev-cpp/glibmm-2.24:2
	>=x11-libs/gtk+-2.24:2
	>=dev-cpp/atkmm-2.22.2
	>=dev-cpp/cairomm-1.2.2
	>=dev-cpp/pangomm-2.27.1:1.4
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		media-gfx/graphviz
		dev-libs/libxslt
		app-doc/doxygen )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog PORTING NEWS README"
	G2CONF="${G2CONF}
		--enable-api-atkmm
		--disable-maintainer-mode
		$(use_enable doc documentation)"
}

src_prepare() {
	gnome2_src_prepare

	if ! use test; then
		# don't waste time building tests
		sed 's/^\(SUBDIRS =.*\)tests\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed 1 failed"
	fi

	if ! use examples; then
		# don't waste time building tests
		sed 's/^\(SUBDIRS =.*\)demos\(.*\)$/\1\2/' -i Makefile.am Makefile.in \
			|| die "sed 2 failed"
	fi
}
