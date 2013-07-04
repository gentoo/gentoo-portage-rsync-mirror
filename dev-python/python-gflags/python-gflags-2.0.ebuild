# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gflags/python-gflags-2.0.ebuild,v 1.6 2013/07/04 14:37:09 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Google's Python argument parsing library"
HOMEPAGE="http://code.google.com/p/python-gflags/"
SRC_URI="http://python-gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

PATCHES=(
	# The scripts are installed as 'data' rather than scripts.
	# http://code.google.com/p/python-gflags/issues/detail?id=12
	"${FILESDIR}"/${P}-scripts-install.patch

	# Tests try to write to /tmp (sandbox).
	# http://code.google.com/p/python-gflags/issues/detail?id=13
	"${FILESDIR}"/${P}-tests-respect-tmpdir.patch

	# Skip test as root; Bug #475134
	"{FILESDIR}"/${P}-skip-test-as-root.patch
)

python_test() {
	# http://code.google.com/p/python-gflags/issues/detail?id=15&thanks=15&ts=1372948007
	local t
	cd tests || die
	for t in *.py; do
		# (it's ok to run the gflags_googletest.py too)
		"${PYTHON}" "${t}" || die "Tests fail with ${EPYTHON}"
	done
}
