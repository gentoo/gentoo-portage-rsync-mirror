# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/watchdog/watchdog-0.8.3.ebuild,v 1.2 2015/02/28 20:02:43 maekke Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} pypy)

inherit distutils-r1 eutils

DESCRIPTION="Python API and shell utilities to monitor file system events"
HOMEPAGE="http://github.com/gorakhargosh/watchdog"
SRC_URI="mirror://pypi/w/watchdog/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

CDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	dev-python/argh[${PYTHON_USEDEP}]
	dev-python/pathtools[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-0.3[${PYTHON_USEDEP}]
		)"

python_test() {
	esetup.py test
}

pkg_postinst() {
	optfeature "Bash completion" dev-python/argcomplete
}
