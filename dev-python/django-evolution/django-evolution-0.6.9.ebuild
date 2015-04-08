# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-evolution/django-evolution-0.6.9.ebuild,v 1.3 2014/09/23 00:37:35 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A Django application that will run cron jobs for other django apps"
HOMEPAGE="http://code.google.com/p/django-evolution/ http://pypi.python.org/pypi/django_evolution/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/django[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

python_prepare_all() {
	# Fix installing 'tests' package in the global scope.
	# http://code.google.com/p/django-evolution/issues/detail?id=134
	sed -i -e 's:find_packages(:&exclude=("tests",):' setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	# http://code.google.com/p/django-evolution/issues/detail?id=135
	# This is tested, any delay in die subsequent to (implicitly inherited) multiprocessing eclass
	"${PYTHON}" tests/runtests.py || die
}

python_install_all() {
	distutils-r1_python_install_all
	dodoc -r docs/
}
