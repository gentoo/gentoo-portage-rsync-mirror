# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/synaptiks/synaptiks-0.8.1-r4.ebuild,v 1.7 2014/08/25 15:05:22 mrueg Exp $

EAPI=5

KDE_HANDBOOK="optional"
PYTHON_COMPAT=( python2_7 )
inherit kde4-base distutils-r1

DESCRIPTION="Touchpad configuration and management tool for KDE"
HOMEPAGE="http://synaptiks.readthedocs.org"
SRC_URI="mirror://pypi/s/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug doc +upower"

RDEPEND="
	>=dev-python/PyQt4-4.7[${PYTHON_USEDEP}]
	>=dev-python/pyudev-0.8[pyqt4,${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	$(add_kdebase_dep pykde4 "${PYTHON_USEDEP}" )
	$(add_kdebase_dep kde-dev-scripts)
	>=x11-drivers/xf86-input-synaptics-1.3
	>=x11-libs/libXi-1.4
	x11-libs/libXtst
	upower? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		|| ( >=sys-power/upower-0.9.23 sys-power/upower-pm-utils )
	)
"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	sys-devel/gettext
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		>=dev-python/sphinxcontrib-issuetracker-0.11-r1[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/${P}-templatesfix.patch"
	"${FILESDIR}/${PN}-0.8.1-removedfeatures.patch"
)

python_compile_all() {
	if use doc; then
		einfo "Generating documentation"
		pushd doc > /dev/null
		sphinx-build . _build || die
		popd > /dev/null
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/. )
	distutils-r1_python_install_all
}
