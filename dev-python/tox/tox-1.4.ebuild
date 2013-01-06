# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tox/tox-1.4.ebuild,v 1.1 2012/06/28 07:42:28 patrick Exp $

EAPI=4

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="virtualenv-based automation of test activities"
HOMEPAGE="http://tox.testrun.org http://pypi.python.org/pypi/tox"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
		dev-python/virtualenv
		dev-python/pip
		>=dev-python/pytest-2.2.3"
RDEPEND="${DEPEND}"

#src_test() {
#	testing() {
#		py.test -x
#	}
#	python_execute_function testing
#}
