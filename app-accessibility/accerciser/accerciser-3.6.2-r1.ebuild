# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/accerciser/accerciser-3.6.2-r1.ebuild,v 1.1 2012/12/16 07:21:16 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml"

inherit gnome2 python-r1

DESCRIPTION="Interactive Python accessibility explorer"
HOMEPAGE="http://live.gnome.org/Accerciser"

LICENSE="BSD CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=app-accessibility/at-spi2-core-2.1.5:2
	>=dev-python/pygobject-2.90.3:3[${PYTHON_USEDEP}]
	>=x11-libs/gtk+-3.1.13:3[introspection]

	dev-libs/atk[introspection]
	>=dev-libs/glib-2.28:2
	dev-libs/gobject-introspection
	>=dev-python/ipython-0.11
	>=dev-python/pyatspi-2.1.5[${PYTHON_USEDEP}]
	dev-python/pycairo
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/libwnck:3[introspection]
	x11-libs/pango[introspection]
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} ITSTOOL=$(type -P true)"

	gnome2_src_prepare

	python_copy_sources
}

src_configure() {
	python_foreach_impl run_in_build_dir gnome2_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_install() {
	installing() {
		gnome2_src_install
		python_doscript src/accerciser
	}
	python_foreach_impl run_in_build_dir installing
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}
