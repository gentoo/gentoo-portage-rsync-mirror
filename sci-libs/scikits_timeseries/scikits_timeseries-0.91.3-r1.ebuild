# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_timeseries/scikits_timeseries-0.91.3-r1.ebuild,v 1.1 2013/02/09 19:38:49 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_P="${P/scikits_/scikits.}"

DESCRIPTION="SciPy module for manipulating, reporting, and plotting time series"
HOMEPAGE="http://pytseries.sourceforge.net/index.html"
SRC_URI="
	mirror://sourceforge/pytseries/${MY_P}.tar.gz
	doc? ( mirror://sourceforge/pytseries/${MY_P}-html_docs.zip )"

LICENSE="BSD eGenixPublic-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND="
	sci-libs/scipy[${PYTHON_USEDEP}]
	sci-libs/scikits[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pytables"

S="${WORKDIR}/${MY_P}"

python_test() {
	esetup.py test
}

python_install() {
	distutils-r1_python_install
	rm -f "${ED}"$(python_get_sitedir)/scikits/__init__.py || die
}

python_install_all() {
	use doc && HTMLDOCS=( "${WORKDIR}/html" )
	distutils-r1_python_install_all
}
