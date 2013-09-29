# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imapclient/imapclient-0.10.2.ebuild,v 1.1 2013/09/29 19:29:18 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

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

	# use system six library
	rm imapclient/six.py || die
	epatch "${FILESDIR}"/${P}-system-six.patch

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
