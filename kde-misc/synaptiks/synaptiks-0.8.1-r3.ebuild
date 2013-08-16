# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.8.1-r3.ebuild,v 1.2 2013/08/16 10:08:41 mrueg Exp $

EAPI=5

KDE_HANDBOOK=optional
PYTHON_COMPAT=( python2_6 python2_7 )
inherit kde4-base distutils-r1

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://synaptiks.readthedocs.org"
SRC_URI="mirror://pypi/s/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc +upower"

RDEPEND="
	>=dev-python/PyQt4-4.7[${PYTHON_USEDEP}]
	>=dev-python/pyudev-0.8[pyqt4,${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}" )
	|| (
		( $(add_kdebase_dep kdesdk-scripts) )
		( $(add_kdebase_dep kde-dev-scripts) )
	)
	virtual/python-argparse[${PYTHON_USEDEP}]
	>=x11-drivers/xf86-input-synaptics-1.3
	>=x11-libs/libXi-1.4
	x11-libs/libXtst
	upower? ( dev-python/dbus-python[${PYTHON_USEDEP}]
		sys-power/upower )"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	sys-devel/gettext
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-issuetracker[${PYTHON_USEDEP}]
	)"

src_prepare() {
	epatch "${FILESDIR}/${P}-templatesfix.patch"\
		"${FILESDIR}/${PN}-0.8.1-removedfeatures.patch"
}

src_compile() {
	distutils-r1_src_compile
	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		sphinx-build . _build || die
		popd > /dev/null
	fi
}

src_install() {
	distutils-r1_src_install
	if use doc; then
		dohtml -r doc/_build/*
	fi
}
