# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goocanvas/goocanvas-2.0.1-r1.ebuild,v 1.1 2013/08/12 04:06:56 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools eutils gnome2 python-r1

DESCRIPTION="Canvas widget for GTK+ using the cairo 2D library for drawing"
HOMEPAGE="http://live.gnome.org/GooCanvas"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${P}-patches-p20130718.tar.xz"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples +introspection python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# python only enables python specific binding override
RDEPEND=">=x11-libs/gtk+-3.0.0:3
	>=dev-libs/glib-2.28.0:2
	>=x11-libs/cairo-1.10.0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	python? (
		${PYTHON_DEPS}
		dev-python/pygobject:3[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig"

src_prepare() {
	# from upstream git master
	epatch "../${P}-patches-p20130718/"*.patch

	# https://bugzilla.gnome.org/show_bug.cgi?id=671766
	epatch "${FILESDIR}"/${P}-gold.patch

	eautoreconf

	# Do not build demos
	sed -e 's/^\(SUBDIRS =.*\)demo\(.*\)$/\1\2/' \
		-i Makefile.am Makefile.in || die "sed failed"

	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS = python/d" -i bindings/Makefile.am bindings/Makefile.in

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-rebuilds \
		--disable-static \
		$(use_enable introspection) \
		--disable-python
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	gnome2_src_install

	if use python; then
		sub_install() {
			python_moduleinto $(python -c "import gi;print gi._overridesdir")
			python_domodule bindings/python/GooCanvas.py
		}
		python_foreach_impl sub_install
	fi

	if use examples; then
		insinto "/usr/share/doc/${P}/examples/"
		doins demo/*.[ch] demo/*.png
	fi
}
