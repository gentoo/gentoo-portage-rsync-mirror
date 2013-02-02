# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astng/astng-0.24.1.ebuild,v 1.3 2013/02/02 22:27:54 ago Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="Abstract Syntax Tree New Generation for logilab packages"
HOMEPAGE="http://www.logilab.org/project/logilab-astng http://pypi.python.org/pypi/logilab-astng"
SRC_URI="ftp://ftp.logilab.org/pub/astng/logilab-${P}.tar.gz mirror://pypi/l/logilab-astng/logilab-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND=">=dev-python/logilab-common-0.53.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( >=dev-python/egenix-mx-base-3.0.0 )"

S="${WORKDIR}/logilab-${P}"
PYTHON_MODNAME="logilab/astng"
DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_test() {
	testing() {
		local tpath="${T}/test-${PYTHON_ABI}"
		local spath="${tpath}$(python_get_sitedir)"

		mkdir -p "${spath}/logilab" || return 1
		cp -r "$(python_get_sitedir)/logilab/common" "${spath}/logilab" || return 1

		"$(PYTHON)" setup.py build -b build install --root="${tpath}" ||
			die "Installation for tests failed with $(python_get_implementation_and_version)"

		# pytest uses tests placed relatively to the current directory.
		pushd "${spath}/logilab/astng" > /dev/null || return 1
		PYTHONPATH="${spath}" pytest -v || return 1
		popd > /dev/null || return 1
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	deletion_of_unneeded_files() {
		# Avoid collision with dev-python/logilab-common.
		rm -f "${ED}$(python_get_sitedir)/logilab/__init__.py" || return 1

		# Don't install tests.
		rm -fr "${ED}$(python_get_sitedir)/logilab/astng/test" || return 1
	}
	python_execute_function -q deletion_of_unneeded_files
}
