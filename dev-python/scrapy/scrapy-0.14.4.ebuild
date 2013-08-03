# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scrapy/scrapy-0.14.4.ebuild,v 1.5 2013/08/03 09:45:47 mgorny Exp $

EAPI="4"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite(+)"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="2.5"
inherit distutils

MY_PN="Scrapy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A high-level Python Screen Scraping framework"
HOMEPAGE="http://scrapy.org http://pypi.python.org/pypi/Scrapy/"
SRC_URI="mirror://pypi/S/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boto doc examples ibl test ssl"
PYTHON_MODNAME="scrapy scrapyd"

DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		dev-python/django
		net-ftp/vsftpd
	)"
RDEPEND="dev-libs/libxml2[python]
	boto? ( dev-python/boto )
	virtual/python-imaging
	dev-python/lxml
	ibl? ( dev-python/numpy )
	ssl? ( dev-python/pyopenssl )
	dev-python/setuptools
	dev-python/simplejson
	dev-python/twisted-core
	dev-python/twisted-conch
	dev-python/twisted-mail
	dev-python/twisted-web
	>=dev-python/w3lib-1.1"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		emake -C docs html || die "emake html failed"
	fi
}

src_test() {
	testing() {
		# PYTHOPATH should be build-$PYTHON_ABI/lib, but causes a test fail.
		# Not all content is copied across to build-$PYTHON_ABI/lib, and
		# PYTHONPATH again requires an abs path.
		echo PYTHONPATH="${PWD}" bin/runtests.sh
		PYTHONPATH="${PWD}"/ bin/runtests.sh
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r "${S}"/docs/build/html/
	fi
	if use examples; then
		insinto /usr/share/doc/"${PF}"/examples
		doins -r "${S}"/examples/*
	fi
}
