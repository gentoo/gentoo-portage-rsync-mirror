# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/genshi/genshi-0.6.ebuild,v 1.10 2013/12/04 13:25:19 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
# Need call setup.py test manually making this for now redundant
#DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_P="Genshi-${PV}"

DESCRIPTION="Python toolkit for stream-based generation of output for the web"
HOMEPAGE="http://genshi.edgewall.org/ http://pypi.python.org/pypi/Genshi"
SRC_URI="ftp://ftp.edgewall.com/pub/genshi/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples"

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	cp genshi/filters/tests/html.py orig_html.py || die
	epatch "${FILESDIR}"/${P}-html_test.patch
}

src_test() {
	# The html_test.patch is needed only for python2.7 for now, breaks all other versions. The html.py needs
	# adjusting only to pass the tests for 2.7. Other ABIs still need the original filters/tests/html.py,
	# hence this long winded juggling appears the only method to set a viable genshi/filters/tests/html.py
	# for each python version. The test needed patching, instead they changed the genshi/filters/tests/html.py
	setHtmlpy() {
		for f in build-${PYTHON_ABI}; do
			if [[ ${PYTHON_ABI:2:3} < '7' || ${PYTHON_ABI:4:4} == "pypy" ]]; then
				mv genshi/filters/tests/html.py patched_html.py || die
				mv orig_html.py genshi/filters/tests/html.py || die
				"$(PYTHON)" setup.py test
				mv genshi/filters/tests/html.py orig_html.py
				mv patched_html.py genshi/filters/tests/html.py || die
			else
				"$(PYTHON)" setup.py test
			fi
		done
	}
	python_execute_function setHtmlpy
}

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/*.txt
		dohtml -r doc/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
