# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-levenshtein/python-levenshtein-0.10.2.ebuild,v 1.5 2012/12/17 17:10:46 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="python-Levenshtein"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Functions for fast computation of Levenshtein (edit) distance, and edit operations"
HOMEPAGE="http://github.com/miohtama/python-Levenshtein/tree/
	http://pypi.python.org/pypi/python-Levenshtein/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="$(ls -d build-$(PYTHON -f --ABI)/lib.*)" "$(PYTHON -f)" "${FILESDIR}/genextdoc.py" Levenshtein || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml Levenshtein.html || die "Installation of documentation failed"
	fi
}
