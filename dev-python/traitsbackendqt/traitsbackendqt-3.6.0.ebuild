# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendqt/traitsbackendqt-3.6.0.ebuild,v 1.6 2012/06/12 12:02:05 iksaif Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="TraitsBackendQt"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PyQt backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui/"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="dev-python/PyQt4[X]
	dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install
}
