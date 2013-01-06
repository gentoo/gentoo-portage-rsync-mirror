# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.24.3.ebuild,v 1.15 2012/05/29 16:23:38 aballier Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="GNOME CORBA framework"
HOMEPAGE="http://developer.gnome.org/libbonobo/stable/"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="debug doc examples test"

RDEPEND=">=dev-libs/glib-2.14:2
	>=gnome-base/orbit-2.14.0
	>=dev-libs/libxml2-2.4.20:2
	>=sys-apps/dbus-1.0.0
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/popt-1.5
	!gnome-base/bonobo-activation"
DEPEND="${RDEPEND}
	virtual/yacc
	sys-devel/flex
	x11-apps/xrdb
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1 )"

# Tests are broken in several ways as reported in bug #288689 and upstream
# doesn't take care since libbonobo is deprecated.
RESTRICT="test"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable debug bonobo-activation-debug)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix intltoolize broken file, see upstream #577133
	sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in || die

	if ! use test; then
		# don't waste time building tests, bug #226223
		sed 's/tests//' -i Makefile.am Makefile.in || die
	fi

	if ! use examples; then
		sed 's/samples//' -i Makefile.am Makefile.in || die
	fi
}

src_test() {
	# Pass tests with FEATURES userpriv, see bug #288689
	unset ORBIT_SOCKETDIR
	emake check || die
}
