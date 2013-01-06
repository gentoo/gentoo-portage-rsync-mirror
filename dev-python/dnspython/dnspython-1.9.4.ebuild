# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dnspython/dnspython-1.9.4.ebuild,v 1.7 2012/12/01 01:59:06 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ http://pypi.python.org/pypi/dnspython"
SRC_URI="http://www.dnspython.org/kits/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="examples"

DEPEND="dev-python/pycrypto"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README TODO"
PYTHON_MODNAME="dns"

src_test() {
	cd tests

	testing() {
		local exit_status="0" test
		for test in *.py; do
			echo "Running ${test}..."
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || exit_status="1"
		done
		return "${exit_status}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/* || die "Installation of examples failed"
	fi
}
