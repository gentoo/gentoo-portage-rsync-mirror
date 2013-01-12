# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/qtile/qtile-0.5-r1.ebuild,v 1.1 2013/01/12 06:07:09 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 vcs-snapshot virtualx

DESCRIPTION="A full-featured, hackable tiling window manager written in Python"
HOMEPAGE="http://qtile.org/"
SRC_URI="https://github.com/qtile/qtile/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/pycairo-1.10.0-r3[xcb]
	dev-python/pygtk:2
	>=x11-libs/xpyb-1.3.1"
DEPEND="doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/python-xlib
		x11-base/xorg-server[kdrive]
	)"

# tests fail due to xauth errors from python-xlib
RESTRICT="test"

DOCS="TODO.rst"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	VIRTUALX_COMMAND="nosetests" virtualmake
}

python_install_all() {
	use doc && dohtml -r docs/_build/html/*

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
}
