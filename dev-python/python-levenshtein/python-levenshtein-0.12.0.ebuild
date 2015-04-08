# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-levenshtein/python-levenshtein-0.12.0.ebuild,v 1.1 2014/12/18 05:48:08 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

MY_PN="python-Levenshtein"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Functions for fast computation of Levenshtein (edit) distance, and edit operations"
HOMEPAGE="http://github.com/miohtama/python-Levenshtein/tree/
	http://pypi.python.org/pypi/python-Levenshtein/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	if use doc; then
		# Cannot assume user has a system py2 or pypy
		if python_is_python3; then
			die "The build of Levenshtein.html is not supported by python3"
		else
			einfo "Generation of documentation"
			"${PYTHON}" "${FILESDIR}/genextdoc.py" Levenshtein || die "Generation of documentation failed"
		fi
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( Levenshtein.html )
	distutils-r1_python_install_all
}
