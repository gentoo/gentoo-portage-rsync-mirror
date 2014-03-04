# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopenssl/pyopenssl-0.14.ebuild,v 1.3 2014/03/04 20:56:03 naota Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 flag-o-matic

MY_PN=pyOpenSSL
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python interface to the OpenSSL library"
HOMEPAGE="http://pyopenssl.sourceforge.net/ https://launchpad.net/pyopenssl http://pypi.python.org/pypi/pyOpenSSL"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=">=dev-python/six-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-0.2.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	sed \
		-e "s/test_set_tlsext_host_name_wrong_args/_&/" \
		-i OpenSSL/test/test_ssl.py || die "test_ssl sed failed"

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	esetup.py test

	# https://bugs.launchpad.net/pyopenssl/+bug/1237953
	rm -rf tmp* *.key *.pem
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
