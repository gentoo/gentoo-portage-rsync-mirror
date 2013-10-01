# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyml/pyml-0.7.13.2.ebuild,v 1.1 2013/10/01 01:12:55 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-pypy-* *-jython"

inherit distutils

MYP=PyML-${PV}

DESCRIPTION="Python machine learning package"
HOMEPAGE="http://pyml.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MYP}"

src_test() {
	cd data
	testing() {
		PYTHONPATH="$(ls -d ${S}/build-${PYTHON_ABI}/lib*)" \
			"$(PYTHON)" -c "from PyML.demo import pyml_test; pyml_test.test('svm')" || return 1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dodoc doc/tutorial.pdf && dohtml -r doc/autodoc/*
}
