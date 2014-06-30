# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rackspace-monitoring-cli/rackspace-monitoring-cli-0.5.2.ebuild,v 1.2 2014/06/30 04:07:10 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

# https://github.com/racker/rackspace-monitoring-cli/issues/49
RESTRICT="test"

inherit distutils-r1

DESCRIPTION="Command Line Utility for Rackspace Cloud Monitoring (MaaS)."
HOMEPAGE="https://github.com/racker/rackspace-monitoring-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

TEST_DEPENDS="dev-python/pep8[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/rackspace-monitoring-0.5.4[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		test? ( ${TEST_DEPENDS} )"

python_test() {
	${EPYTHON} setup.py pep8 || die
}
