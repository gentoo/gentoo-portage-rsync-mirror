# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-levenshtein/python-levenshtein-0.10.ebuild,v 1.8 2012/02/21 07:20:14 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="python-Levenshtein"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Levenshtein contains functions for fast computation of Levenshtein (edit) distance, and edit operations"
HOMEPAGE="http://trific.ath.cx/resources/python/levenshtein/"
SRC_URI="http://trific.ath.cx/Ftp//python/levenshtein/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~x86"
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
