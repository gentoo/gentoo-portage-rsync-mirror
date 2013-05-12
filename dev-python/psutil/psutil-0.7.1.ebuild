# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psutil/psutil-0.7.1.ebuild,v 1.3 2013/05/12 18:07:23 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Retrieve information on running processes and system utilization"
HOMEPAGE="http://code.google.com/p/psutil/ http://pypi.python.org/pypi/psutil"
SRC_URI="http://psutil.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

#RESTRICT="test"
#http://code.google.com/p/psutil/issues/detail?id=379

python_test() {
	"${PYTHON}" test/test_psutil.py || die "Tests fail with ${EPYTHON}"
}
