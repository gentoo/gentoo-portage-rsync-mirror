# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fig/fig-0.5.2.ebuild,v 1.2 2014/11/09 21:06:22 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Punctual, lightweight development environments using Docker"
HOMEPAGE="http://www.fig.sh/"
SRC_URI="https://github.com/docker/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="
	>=dev-python/dockerpty-0.2.3[${PYTHON_USEDEP}]
	<dev-python/dockerpty-0.3[${PYTHON_USEDEP}]
	~dev-python/docopt-0.6.1[${PYTHON_USEDEP}]
	~dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.1[${PYTHON_USEDEP}]
	~dev-python/texttable-0.8.1[${PYTHON_USEDEP}]
	~dev-python/websocket-client-0.11.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${CDEPEND}
		~dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		~dev-python/nose-1.3.0[${PYTHON_USEDEP}]
		dev-python/unittest2[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"

python_prepare_all() {
	ebegin 'patching setup.py'
	sed \
		-e 's/packages=find_packages(/&exclude=["tests.*", "tests"]/' \
		-i setup.py
	STATUS=$?
	eend ${STATUS}
	[[ ${STATUS} -gt 0 ]] && die

	ebegin 'patching requirements.txt'
	sed \
		-e '3s/==/>=/' \
		-i requirements.txt
	STATUS=$?
	eend ${STATUS}
	[[ ${STATUS} -gt 0 ]] && die

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests tests/unit || die "Tests failed under ${EPYTHON}"
}
