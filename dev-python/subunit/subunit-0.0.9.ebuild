# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/subunit/subunit-0.0.9.ebuild,v 1.2 2014/03/19 23:07:21 bicatali Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

# Automake build does not genereate the correct value for site-packages
# with pypy.
RESTRICT_PYTHON_ABIS="*-pypy-*"

inherit python

DESCRIPTION="A streaming protocol for test results"
HOMEPAGE="https://launchpad.net/subunit http://pypi.python.org/pypi/python-subunit"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-python/testtools-0.9.23"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-libs/check
	dev-util/cppunit
	virtual/pkgconfig"

src_prepare() {
	python_clean_py-compile_files
	python_src_prepare
}

src_test() {
	testing() {
		python_convert_shebangs ${PYTHON_ABI} runtests.py || return
		emake check
	}
	python_execute_function -s testing
}

pkg_postinst() {
	python_mod_optimize subunit
}

pkg_postrm() {
	python_mod_cleanup subunit
}
