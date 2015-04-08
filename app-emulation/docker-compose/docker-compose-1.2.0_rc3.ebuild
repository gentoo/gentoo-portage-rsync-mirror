# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/docker-compose/docker-compose-1.2.0_rc3.ebuild,v 1.1 2015/04/05 03:34:14 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit bash-completion-r1 distutils-r1 vcs-snapshot

MY_PV="${PV//_/}"

DESCRIPTION="Multi-container orchestration for Docker"
HOMEPAGE="https://www.docker.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/dockerpty-0.3.2[${PYTHON_USEDEP}]
	<dev-python/dockerpty-0.4[${PYTHON_USEDEP}]
	>=dev-python/docker-py-1.0.0[${PYTHON_USEDEP}]
	<dev-python/docker-py-1.2[${PYTHON_USEDEP}]
	>=dev-python/docopt-0.6.1[${PYTHON_USEDEP}]
	<dev-python/docopt-0.7[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	<dev-python/pyyaml-4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	<dev-python/requests-2.6[${PYTHON_USEDEP}]
	>=dev-python/six-1.3.0[${PYTHON_USEDEP}]
	<dev-python/six-2[${PYTHON_USEDEP}]
	>=dev-python/texttable-0.8.1[${PYTHON_USEDEP}]
	<dev-python/texttable-0.9[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.11.0[${PYTHON_USEDEP}]
	<dev-python/websocket-client-1.0[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		${CDEPEND}
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"

python_test() {
	nosetests tests/unit || die "tests failed under ${EPYTHON}"
}

python_install_all() {
	newbashcomp contrib/completion/bash/docker-compose ${PN}

	distutils-r1_python_install_all
}
