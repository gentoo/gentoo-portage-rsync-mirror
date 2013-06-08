# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyechonest/pyechonest-7.2.1.ebuild,v 1.3 2013/06/08 16:41:45 sochotnicky Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python interface to The Echo Nest APIs"
HOMEPAGE="http://echonest.github.com/pyechonest/"
SRC_URI="https://github.com/echonest/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation by" ${PYTHON}
		PYTHONPATH=".." emake -C doc html || die "Generation of documentation failed"
	fi
}

python_install_all() {
	use doc && dohtml -r doc/build/html/

	if use examples; then
		docompress -x usr/share/doc/${P}/examples/
		insinto usr/share/doc/${P}/examples
		doins -r examples/*
	fi
}
