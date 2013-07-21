# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/flexget/flexget-9999.ebuild,v 1.40 2013/07/21 02:33:33 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1 eutils

if [[ ${PV} != 9999 ]]; then
	MY_P="FlexGet-${PV}"
	SRC_URI="http://download.flexget.com/${MY_P}.tar.gz
		http://download.flexget.com/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-2
	EGIT_REPO_URI="git://github.com/Flexget/Flexget.git
		https://github.com/Flexget/Flexget.git"
fi

DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics"
HOMEPAGE="http://flexget.com/"

LICENSE="MIT"
SLOT="0"
IUSE="test"

DEPEND="
	>=dev-python/feedparser-5.1.3[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.7[${PYTHON_USEDEP}]
	<dev-python/sqlalchemy-0.7.99
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.1:4[${PYTHON_USEDEP}]
	<dev-python/beautifulsoup-4.3:4[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.0[${PYTHON_USEDEP}]
	dev-python/PyRSS2Gen[${PYTHON_USEDEP}]
	dev-python/pynzb[${PYTHON_USEDEP}]
	dev-python/progressbar[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-tvrage[${PYTHON_USEDEP}]
	>=dev-python/requests-1.0[${PYTHON_USEDEP}]
	<dev-python/requests-1.99
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
DEPEND+=" test? ( dev-python/nose[${PYTHON_USEDEP}] )"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" dev-python/paver[${PYTHON_USEDEP}]"
else
	S="${WORKDIR}/${MY_P}"
fi

python_prepare_all() {
	# Prevent setup from grabbing nose from pypi
	sed -e /setup_requires/d -i pavement.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	cp -lr tests setup.cfg "${BUILD_DIR}" || die
	run_in_build_dir nosetests -v --attr=!online > "${T}/tests-${EPYTHON}.log" \
		|| die "Tests fail with ${EPYTHON}"
}
