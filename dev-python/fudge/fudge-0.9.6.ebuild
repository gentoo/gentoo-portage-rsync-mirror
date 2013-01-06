# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fudge/fudge-0.9.6.ebuild,v 1.1 2012/05/16 15:42:54 floppym Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Replace real objects with fakes (mocks, stubs, etc) while testing."
HOMEPAGE="http://farmdev.com/projects/fudge/ http://pypi.python.org/pypi/fudge"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND=""

src_prepare() {
	distutils_src_prepare
	find -name "._*" -print0 | xargs -0 rm -f
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		nosetests build-${PYTHON_ABI}/lib
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/fudge/tests"
	}
	python_execute_function -q delete_tests

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
