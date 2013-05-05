# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-3.7.90.ebuild,v 1.2 2013/05/05 09:37:56 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml"
SUPPORT_PYTHON_ABIS="1"

inherit gnome2 python-r1

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="https://git.gnome.org/browse/alacarte"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=gnome-base/gnome-menus-3.5.3:3[introspection]
"
RDEPEND="${COMMON_DEPEND}
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.0
	sys-devel/gettext
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

src_test() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	installing() {
		gnome2_src_install
		# Massage shebang to make python_doscript happy
		sed -e 's:#! '"${PYTHON}:#!/usr/bin/python:" \
			-i alacarte || die
			python_doscript alacarte
		}
	python_foreach_impl run_in_build_dir installing
}
