# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-pymongo/flask-pymongo-0.1.3.ebuild,v 1.1 2012/10/31 07:39:32 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Flask-PyMongo"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PyMongo support for Flask"
HOMEPAGE="http://pypi.python.org/pypi/Flask-PyMongo"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-python/flask-0.8
	>=dev-python/pymongo-2.1"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	dev-python/setuptools
	dev-python/nose"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		cd docs
		PYTHONPATH=".." emake html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
