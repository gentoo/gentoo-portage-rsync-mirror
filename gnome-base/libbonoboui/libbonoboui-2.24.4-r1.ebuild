# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.24.4-r1.ebuild,v 1.10 2012/05/05 05:38:12 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2 virtualx

DESCRIPTION="User Interface part of libbonobo"
HOMEPAGE="http://library.gnome.org/devel/libbonoboui/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="doc examples test"

# GTK+ dep due to bug #126565
RDEPEND=">=gnome-base/libgnomecanvas-1.116
	>=gnome-base/libbonobo-2.22
	>=gnome-base/libgnome-2.13.7
	>=dev-libs/libxml2-2.4.20:2
	>=gnome-base/gconf-2:2
	>=x11-libs/gtk+-2.8.12:2
	>=dev-libs/glib-2.6.0:2
	>=gnome-base/libglade-1.99.11:2.0
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	x11-apps/xrdb
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	doc? ( >=dev-util/gtk-doc-1 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--disable-maintainer-mode"
}

src_prepare() {
	gnome2_src_prepare

	if ! use test; then
		# don't waste time building tests
		sed 's/tests//' -i Makefile.am Makefile.in || die "sed 1 failed"
	fi

	if ! use examples; then
		sed 's/samples//' -i Makefile.am Makefile.in || die "sed 2 failed"
	fi
}

src_configure() {
	addpredict "/root/.gnome2_private"

	gnome2_src_configure
}

src_test() {
	addwrite "/root/.gnome2_private"
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name '*.la' -exec rm -f {} +
}
