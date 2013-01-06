# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autopep8/autopep8-0.8.4.ebuild,v 1.1 2012/12/07 15:33:04 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"

inherit distutils vcs-snapshot

DESCRIPTION="Automatically formats Python code to conform to the PEP 8 style guide"
HOMEPAGE="https://github.com/hhatto/autopep8 http://pypi.python.org/pypi/autopep8"
SRC_URI="https://github.com/hhatto/${PN}/tarball/ver${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-python/pep8-1.3.2
	dev-python/setuptools"
DEPEND="${RDEPEND}"

PYTHON_MODNAME=${PN}.py

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_${PN}.py
	}
	python_execute_function testing
}

pkg_postinst() {
	distutils_pkg_postinst
	ewarn "Since this version of autopep depends on >=dev-python/pep8-1.3"
	ewarn "it is affected by https://github.com/jcrocholl/pep8/issues/45"
	ewarn "(indentation checks inside triple-quotes)."
	ewarn "If you do not want to be affected by this, then add the"
	ewarn "following lines to your local package.mask:"
	ewarn "  >=dev-python/pep8-1.3"
	ewarn "  >=dev-python/autopep8-0.6"
}
