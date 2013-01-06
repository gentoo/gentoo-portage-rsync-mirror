# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/d-feet/d-feet-0.3.1.ebuild,v 1.2 2012/12/17 19:53:11 mgorny Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=(python2_7 pypy1_9)

inherit gnome2 distutils-r1

DESCRIPTION="D-Feet is a powerful D-Bus debugger"
HOMEPAGE="http://live.gnome.org/DFeet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.34:2
	dev-python/pygobject:3
	>=sys-apps/dbus-1
	x11-libs/gtk+:3[introspection]
	x11-libs/libwnck:3[introspection]
"
DEPEND="
	dev-python/setuptools
"

DOCS=( NEWS )

src_prepare() {
	# Do not run scrollkeeper tools, it is eclass job
	sed "s:scrollkeeper-\(preinstall\|update\):$(type -P true):" \
		-i setup.py || die "sed failed"

	distutils-r1_src_prepare
}
