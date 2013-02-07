# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/orca/orca-3.6.3-r1.ebuild,v 1.8 2013/02/07 21:13:53 ulm Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 ) # incompatible with 3.2 syntax, crashes with 3.3
PYTHON_REQ_USE="threads"

inherit gnome2 python-r1

DESCRIPTION="Extensible screen reader that provides access to the desktop"
HOMEPAGE="http://projects.gnome.org/orca/"

LICENSE="LGPL-2.1+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

# liblouis is not in portage yet
# it is used to provide contracted braille support
# XXX: Check deps for correctness
COMMON_DEPEND="
	>=app-accessibility/at-spi2-atk-2.5.91:2
	>=app-accessibility/at-spi2-core-2.5.91:2
	>=dev-libs/atk-2.5.91
	>=dev-libs/glib-2.28:2
	>=dev-python/pygobject-3.2.2:3[${PYTHON_USEDEP}]
	>=x11-libs/gtk+-3.5.16:3[introspection]
	${PYTHON_DEPS}
"
RDEPEND="${COMMON_DEPEND}
	app-accessibility/speech-dispatcher[python]
	dev-libs/atk[introspection]
	dev-python/pyatspi[${PYTHON_USEDEP}]
	dev-python/pycairo
	dev-python/setproctitle
	x11-libs/libwnck:3[introspection]
	x11-libs/pango[introspection]
"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

src_prepare() {
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
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"
	installing() {
		gnome2_src_install
		# Massage shebang to make python_doscript happy
		sed -e 's:#!'"${PYTHON}:#!/usr/bin/python:" \
			-i src/orca/orca || die
		python_doscript src/orca/orca
	}
	python_foreach_impl run_in_build_dir installing
}

run_in_build_dir() {
	pushd "${BUILD_DIR}" > /dev/null || die
	"$@"
	popd > /dev/null
}
