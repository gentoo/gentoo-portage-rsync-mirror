# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numdisplay/numdisplay-1.6.0.ebuild,v 1.2 2012/08/02 17:51:41 bicatali Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python package for interactively displaying FITS arrays"
HOMEPAGE="http://stsdas.stsci.edu/numdisplay/"
SRC_URI="http://stsdas.stsci.edu/download/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install

	delete_LICENSE() {
		rm -f "${ED}$(python_get_sitedir)/${PN}/LICENSE.txt"
	}
	python_execute_function -q delete_LICENSE
}
