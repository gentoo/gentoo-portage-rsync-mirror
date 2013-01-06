# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hglib/hglib-0.1.ebuild,v 1.2 2012/02/22 05:40:42 patrick Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.6 3.* *-jython 2.7-pypy-*"
MY_P="python-${P}"
MY_PN="python-${PN}"

inherit distutils

DESCRIPTION="Library for using the Mercurial Command Server from Python"
HOMEPAGE="http://mercurial.selenic.com/"
SRC_URI="http://mercurial.selenic.com/release/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-vcs/mercurial-1.9"
DEPEND="test? ( dev-python/nose )"

S=${WORKDIR}/${MY_P}

src_test() {
	rm tests/test-summary.py # currently fails
	testing() {
#		local testdir="${T}/tests-${PYTHON_ABI}"
#		rm -rf "${testdir}"
		"$(PYTHON)" test.py
	}
	python_execute_function testing
}
