# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-evolution/django-evolution-0.6.7.ebuild,v 1.2 2012/05/23 18:58:01 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy"

inherit distutils eutils

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A Django application that will run cron jobs for other django apps"
HOMEPAGE="http://code.google.com/p/django-evolution/ http://pypi.python.org/pypi/django_evolution/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	dev-python/django"

PYTHON_MODNAME=${MY_PN}
S=${WORKDIR}/${MY_P}

src_test() {
	testing() {
		local exit_status=0
		"$(PYTHON)" tests/runtests.py || exit_status=1
		return $exit_status
	}
	python_execute_function testing
}

src_install() {
	local msg="Remove tests to avoid file collisions"
	distutils_src_install

	rmtests() {
		rm -rf "${ED}"/$(python_get_sitedir)/tests/
	}
	python_execute_function --action-message "$msg" rmtests
	dodoc docs/*
}
