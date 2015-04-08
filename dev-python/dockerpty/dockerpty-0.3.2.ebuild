# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dockerpty/dockerpty-0.3.2.ebuild,v 1.1 2014/11/10 02:01:16 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python library to use the pseudo-tty of a docker container"
HOMEPAGE="https://github.com/d11wtq/dockerpty"
SRC_URI="https://github.com/d11wtq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/behave-1.2.4[${PYTHON_USEDEP}]
		>=dev-python/docker-py-0.3.2[${PYTHON_USEDEP}]
		>=dev-python/expects-0.4[${PYTHON_USEDEP}]
		>=dev-python/pytest-2.5.2[${PYTHON_USEDEP}]
	)
"
RDEPEND=">=dev-python/docker-py-0.3.2[${PYTHON_USEDEP}]"

python_test() {
	local RUN_FEATURES=0

	ewarn "${PN} tests require portage to be in the docker group!"
	getent group docker |& grep portage 1>/dev/null 2>&1
	RUN_FEATURES+=$?

	ewarn "${PN} tests require a running docker service!"
	which docker 1>/dev/null 2>&1 && docker info 1>/dev/null 2>&1
	RUN_FEATURES+=$?

	if [[ ${RUN_FEATURES} -eq 0 ]]; then
		behave || die "Feature tests failed under ${EPYTHON}"

	fi

	py.test tests || die "Tests failed under ${EPYTHON}"
}
