# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/alembic/alembic-0.6.3.ebuild,v 1.2 2014/03/22 04:24:16 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

#RESTRICT="test" # 501362

inherit distutils-r1

DESCRIPTION="database migrations tool, written by the author of SQLAlchemy"
HOMEPAGE="https://bitbucket.org/zzzeek/alembic"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

RDEPEND=">=dev-python/sqlalchemy-0.7.3[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		~dev-python/sqlalchemy-0.8.2[${PYTHON_USEDEP}] )"

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )

	distutils-r1_python_install_all
}

python_test() {
	cp -r test.cfg tests "${BUILD_DIR}" || die
	cd "${BUILD_DIR}" || die
	if [[ ${EPYTHON} == python3* ]]; then
		2to3 -w -n tests || die
	fi
	nosetests || die "Testing failed with ${EPYTHON}"
}
