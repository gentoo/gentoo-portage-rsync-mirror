# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtf-peewee/wtf-peewee-0.2.3.ebuild,v 1.2 2014/07/07 02:45:44 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Small python ORM"
HOMEPAGE="https://github.com/coleifer/peewee/"
SRC_URI="https://github.com/coleifer/${PN}/archive/${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=">=dev-python/peewee-2.0.0[${PYTHON_USEDEP}]
	dev-python/wtforms[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( "${RDEPEND}" )"

python_prepare_all() {
	 # https://github.com/coleifer/peewee/issues/361
	sed -e s':test_null_form_saving:_&:' -i "${PN/\-/}"/tests.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" ./runtests.py || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
