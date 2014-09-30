# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/google-apputils/google-apputils-0.4.0.ebuild,v 1.1 2014/09/30 05:05:00 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Collection of utilities for building Python applications"
HOMEPAGE="http://code.google.com/p/google-apputils-python/"
SRC_URI="http://google-apputils-python.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/python-dateutil:python-2
		dev-python/python-gflags[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/mox[${PYTHON_USEDEP}] )"

# version borders needed are already confluent with versions in the tree

python_test() {
	# These yield 2 fails which are in fact expected errors run from a shell script!
	# They seemingly have no immediate mechanism to exit 0 in an expected fail style.
	for test in tests/{app_test*.py,[b-s]*.py}
	do
		"${PYTHON}" $test || die "test failure under ${EPYTHON}"
	done
}
