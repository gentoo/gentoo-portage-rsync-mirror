# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/alembic/alembic-0.4.2.ebuild,v 1.1 2013/02/03 03:41:02 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
# NOTE: I haven't tested if python <2.7 works.
# TODO: python 3.x support bugs: 
# https://bitbucket.org/zzzeek/alembic/issue/102/alembic-042-tests-does-not-pass-on-python
# TODO: dependency on sqlalchemy <0.7.9 does not pass test suite bugs: 
# https://bitbucket.org/zzzeek/alembic/issue/96/testsuite-does-not-pass not pass

inherit distutils-r1

DESCRIPTION="database migrations tool, written by the author of SQLAlchemy"
HOMEPAGE="https://bitbucket.org/zzzeek/alembic"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test doc"

RDEPEND=">=dev-python/sqlalchemy-0.7.9
	dev-python/mako
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_install_all() {
	use doc && local HTML_DOCS=( docs/. )

	distutils-r1_python_install_all
}

python_test() {
	nosetests || die
	# NOTE: don't use setup.py test bugs: https://bitbucket.org/zzzeek/alembic/issue/96/testsuite-does-not-pass
}
