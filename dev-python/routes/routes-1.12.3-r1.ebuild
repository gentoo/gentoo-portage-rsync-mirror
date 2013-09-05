# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/routes/routes-1.12.3-r1.ebuild,v 1.2 2013/09/05 18:46:14 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

MY_PN="Routes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python re-implementation of the Rails routes system for mapping URL's to Controllers/Actions."
HOMEPAGE="http://routes.groovie.org http://pypi.python.org/pypi/Routes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_install() {
	distutils-r1_python_install

	if use doc; then
		cd docs/_build/html
		docinto html
		cp -R [a-z]* _images _static "${ED}usr/share/doc/${PF}/html" || die "Installation of documentation failed"
	fi
}
