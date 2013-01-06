# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testtools/testtools-0.9.15.ebuild,v 1.9 2012/07/28 13:03:04 blueness Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"
inherit distutils versionator

SERIES="$(get_version_component_range 1-2)"

DESCRIPTION="Extensions to the Python unittest library"
HOMEPAGE="https://launchpad.net/testtools http://pypi.python.org/pypi/testtools"
SRC_URI="http://launchpad.net/${PN}/${SERIES}/${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	distutils_src_compile

	if [[ ! -e testtools/_compat2x.py ]]; then
		die "_compat2x.py removed upstream; fix src_compile"
	fi

	fix_compat() {
		# _compat2x.py is expected to have syntax incompatible with python 3.
		# This breaks compileall. Replace with "raise SyntaxError".
		if [[ $(python_get_version -l --major) == 3 ]]; then
			echo "raise SyntaxError" > build-${PYTHON_ABI}/lib/testtools/_compat2x.py
		fi
	}
	python_execute_function -q fix_compat
}

# dev-python/subunit imports some objects from testtools.tests.helpers, so
# tests need to be installed.
