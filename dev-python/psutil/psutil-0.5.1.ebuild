# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psutil/psutil-0.5.1.ebuild,v 1.1 2012/07/11 22:14:04 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Retrieve information on running processes and system utilization"
HOMEPAGE="http://code.google.com/p/psutil/ http://pypi.python.org/pypi/psutil"
SRC_URI="http://psutil.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# A broken test
RESTRICT="test"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" test/test_psutil.py
	}
	python_execute_function testing
}
