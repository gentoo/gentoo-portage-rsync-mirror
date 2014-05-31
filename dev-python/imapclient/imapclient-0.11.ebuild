# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imapclient/imapclient-0.11.ebuild,v 1.1 2014/05/31 03:59:35 idella4 Exp $

EAPI=5
# "Python versions 2.6, 2.7, 3.2 and 3.3 are officially supported" therefore 
# NOT adding py3.4 since it doesn't testsuite desn't even get started since it's clearly not ready
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy )

inherit distutils-r1

MY_PN="IMAPClient"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="easy-to-use, pythonic, and complete IMAP client library"
HOMEPAGE="http://imapclient.freshfoo.com/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	# use system setuptools
	sed -i '/use_setuptools/d' setup.py || die

	# drop explicit mock version test dep
	sed -i "/tests_require/s:'mock==.\+':'mock':" setup.py || die

	# use system six library. patch proven less preferable to use of sed (< maintenance)
	# but a copy of the working hunks from prior version works fine for now.
	rm imapclient/six.py || die
	epatch "${FILESDIR}"/${P}-system-six.patch
	sed -e 's:from .six:from six:g' \
		-e 's:from . import six:import six:g' \
		-i ${PN}/*.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	esetup.py test
}

python_install() {
	distutils-r1_python_install
	# don't install examples and tests in module dir
	rm -r "${ED}"$(python_get_sitedir)/imapclient/{examples,test} || die
}

python_install_all() {
	local DOCS=( AUTHORS HACKING.rst NEWS.rst README.rst THANKS )
	use doc && local HTML_DOCS=( doc/html/. )
	distutils-r1_python_install_all
	use examples && dodoc -r ${PN}/examples
}
