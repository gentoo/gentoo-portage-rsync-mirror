# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-levenshtein/python-levenshtein-0.10.2-r1.ebuild,v 1.2 2013/05/19 10:15:52 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="python-Levenshtein"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Functions for fast computation of Levenshtein (edit) distance, and edit operations"
HOMEPAGE="http://github.com/miohtama/python-Levenshtein/tree/
	http://pypi.python.org/pypi/python-Levenshtein/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		"${PYTHON}" "${FILESDIR}/genextdoc.py" Levenshtein || die "Generation of documentation failed"
	fi
}

python_install_all() {
	if use doc; then
		 dodoc README.rst Levenshtein.html
	else
		dodoc README.rst
	fi
}
