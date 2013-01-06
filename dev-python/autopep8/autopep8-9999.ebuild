# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autopep8/autopep8-9999.ebuild,v 1.5 2012/06/16 14:07:32 sping Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5-cpython"

if [ "${PV%9999}" != "${PV}" ] ; then
	SCM=git-2
	EGIT_REPO_URI="git://github.com/hhatto/${PN}.git"
fi

inherit distutils ${SCM}

DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 http://pypi.python.org/pypi/autopep8"
if [ "${PV%9999}" != "${PV}" ] ; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/pep8-1.3
	dev-python/setuptools"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="${PN}.py"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_${PN}.py
	}
	python_execute_function testing
}
