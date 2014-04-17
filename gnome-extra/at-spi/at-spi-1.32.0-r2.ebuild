# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/at-spi/at-spi-1.32.0-r2.ebuild,v 1.9 2014/04/17 07:48:52 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit gnome2 python-r1

DESCRIPTION="The Gnome Accessibility Toolkit"
HOMEPAGE="http://projects.gnome.org/accessibility/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 arm ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/atk-1.29.2
	>=x11-libs/gtk+-2.19.7:2
	>=gnome-base/libbonobo-1.107
	>=gnome-base/orbit-2
	>=dev-libs/dbus-glib-0.76
	>=gnome-base/gconf-2
	dev-libs/popt

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40

	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/inputproto
	x11-proto/xproto
"
# eautoreconf needs:
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am

# needs a live properly configured environment. Not really suited to
# an ebuild restricted environment
RESTRICT="test"

src_prepare() {
	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	# relocate must be explicitely set
	python_foreach_impl run_in_build_dir gnome2_src_configure \
		--enable-sm \
		--enable-relocate \
		--disable-xevie
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_install() {
	python_foreach_impl run_in_build_dir gnome2_src_install \
		referencedir="${EPREFIX}/usr/share/doc/${PF}/reference/html"
}
