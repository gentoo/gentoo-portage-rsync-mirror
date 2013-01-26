# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/d-feet/d-feet-0.3.3.ebuild,v 1.1 2013/01/25 23:39:42 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_7 )

inherit gnome2 distutils-r1

DESCRIPTION="D-Feet is a powerful D-Bus debugger"
HOMEPAGE="http://live.gnome.org/DFeet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.34:2
	>=dev-python/pygobject-3.3.91:3[${PYTHON_USEDEP}]
	>=sys-apps/dbus-1
	>=x11-libs/gtk+-3.6:3[introspection]
	x11-libs/libwnck:3[introspection]
"
DEPEND="
	${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

DOCS=( NEWS )

src_prepare() {
	# Do not run scrollkeeper tools, it is eclass job
	sed "s:scrollkeeper-\(preinstall\|update\):$(type -P true):" \
		-i setup.py || die

	distutils-r1_src_prepare
}
