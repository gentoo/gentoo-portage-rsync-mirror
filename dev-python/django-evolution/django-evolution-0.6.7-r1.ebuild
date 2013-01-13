# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-evolution/django-evolution-0.6.7-r1.ebuild,v 1.1 2013/01/13 09:21:23 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1 eutils

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
	dev-python/django"

S=${WORKDIR}/${MY_P}

python_test() {
	testing() {
		local exit_status=0
		"$(PYTHON)" tests/runtests.py || exit_status=1
		return $exit_status
	}
	python_execute_function testing
}

src_install() {
	distutils-r1_src_install

	local msg="Remove tests to avoid file collisions"
	rmtests() {
		rm -rf "${ED}"/$(python_get_sitedir)/tests/
	}
	python_execute_function --action-message "$msg" rmtests
	dodoc -r docs/
}
