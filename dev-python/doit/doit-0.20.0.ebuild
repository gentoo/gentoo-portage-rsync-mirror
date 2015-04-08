# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/doit/doit-0.20.0.ebuild,v 1.4 2015/04/08 08:05:07 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} pypy )
inherit eutils distutils-r1

DESCRIPTION="Automation tool"
HOMEPAGE="http://python-doit.sourceforge.net/ http://pypi.python.org/pypi/doit"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=""
RDEPEND="dev-python/pyinotify[${PYTHON_USEDEP}]"

python_prepare_all() {
	use test && DISTUTILS_IN_SOURCE_BUILD=1
	sed -e 's:from .conf:from conf:' -i tests/test_dependency.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	local test
	# https://bitbucket.org/schettino72/doit/issue/48/test-suite-has-me-perplexed-doit-0200
	# "${PYTHON}" runtests.py  # How it's supposed to work
	# How it works
	if [[ "${EPYTHON}" == python3* ]]; then
		einfo "tests don't work for py3"
	else
		for test in tests/test_*.py
		do
			if ! "${PYTHON}" $test; then
				die "Test $test failed under ${EPYTHON}"
			else
				einfo "Test ${test#tests/} passed under ${EPYTHON}"
			fi
		done
	fi
}

src_install() {
	distutils-r1_src_install

	dodoc AUTHORS CHANGES README TODO.txt dev_requirements.txt
	dodoc -r doc
	docompress -x /usr/share/doc/${PF}/doc
}
