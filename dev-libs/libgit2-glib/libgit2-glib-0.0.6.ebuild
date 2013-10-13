# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgit2-glib/libgit2-glib-0.0.6.ebuild,v 1.3 2013/10/13 07:35:24 pacho Exp $

EAPI=5
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit gnome2 python-r1

DESCRIPTION="Git library for GLib"
HOMEPAGE="https://live.gnome.org/Libgit2-glib"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	>=dev-libs/libgit2-0.19.0
	>=dev-libs/glib-2.28.0:2
	>=dev-libs/gobject-introspection-0.10.1
	python? (
		${PYTHON_DEPS}
		dev-python/pygobject:3[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
"

src_configure() {
	gnome2_src_configure $(use_enable python)
}
