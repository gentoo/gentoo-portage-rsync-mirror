# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scrapy/scrapy-0.20.0.ebuild,v 1.1 2014/06/25 04:57:58 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="sqlite(+)"

inherit vcs-snapshot distutils-r1

DESCRIPTION="A high-level Python Screen Scraping framework"
HOMEPAGE="http://scrapy.org http://pypi.python.org/pypi/Scrapy/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boto doc ibl test ssl"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	ibl? ( dev-python/numpy[${PYTHON_USEDEP}] )
	ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
	boto? ( dev-python/boto[${PYTHON_USEDEP}] )
	>=dev-python/twisted-core-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-conch-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-mail-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-web-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/w3lib-1.2[${PYTHON_USEDEP}]
	dev-python/queuelib[${PYTHON_USEDEP}]
	>=dev-python/cssselect-0.9[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( ${RDEPEND}
		dev-python/boto[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]
		net-ftp/vsftpd
		dev-python/pillow[${PYTHON_USEDEP}] )"

REQUIRED_USE="test? ( ssl boto )"

python_prepare_all() {
	# Skip failing tests; https://github.com/scrapy/scrapy/issues/725
	sed -e s':test_process_parallel_failure:_&:' \
		 -i scrapy/tests/test_utils_defer.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		PYTHONPATH="${S}" emake -C docs html || die "emake html failed"
	fi
}

python_test() {
	PYTHONPATH="${PWD}" bin/runtests.sh || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
