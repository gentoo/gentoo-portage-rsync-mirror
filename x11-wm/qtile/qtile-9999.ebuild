# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/qtile/qtile-9999.ebuild,v 1.11 2015/01/20 15:53:12 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 virtualx

if [[ ${PV} == 9999* ]] ; then
	EGIT_REPO_URI="https://github.com/qtile/qtile.git"
	inherit git-r3
else
	SRC_URI="https://github.com/qtile/qtile/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A full-featured, hackable tiling window manager written in Python"
HOMEPAGE="http://qtile.org/"

LICENSE="MIT"
SLOT="0"
IUSE="doc test"

RDEPEND="
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.6[${PYTHON_USEDEP}]
	>=dev-python/cffi-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/xcffib-0.1.10[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (
		${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/python-xlib[${PYTHON_USEDEP}]
		x11-base/xorg-server[kdrive]
	)
"

# tests fail due to xauth errors from python-xlib
RESTRICT="test"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	VIRTUALX_COMMAND="nosetests" virtualmake
}

python_install_all() {
	local DOCS=( CHANGELOG README.rst )
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
}
