# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/qtile/qtile-9999.ebuild,v 1.1 2012/11/13 05:03:09 radhermit Exp $

EAPI="5"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="libqtile"
DISTUTILS_SRC_TEST="nosetests"

inherit git-2 distutils virtualx

EGIT_REPO_URI="git://github.com/qtile/qtile.git"

DESCRIPTION="A full-featured, hackable tiling window manager written in Python"
HOMEPAGE="http://qtile.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

RDEPEND=">=dev-python/pycairo-1.10.0-r3[xcb]
	dev-python/pygtk:2
	>=x11-libs/xpyb-1.3.1"
DEPEND="doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		dev-python/python-xlib
		x11-base/xorg-server[kdrive]
	)"

# tests fail due to xauth errors from python-xlib
RESTRICT="test"

DOCS="TODO.rst"

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	testing() {
		VIRTUALX_COMMAND="nosetests"
		PYTHONPATH="build-${PYTHON_ABI}/lib" virtualmake
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r docs/_build/html/*

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
}
