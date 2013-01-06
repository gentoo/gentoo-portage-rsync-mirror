# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-compressor/django-compressor-1.1.2.ebuild,v 1.1 2012/04/25 12:37:22 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

MY_PN="${PN/-/_}"
DESCRIPTION="Allows to define regrouped/postcompiled content 'on the fly' inside of django template"
HOMEPAGE="http://pypi.python.org/pypi/django_compressor/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

LICENSE="MIT"
SLOT="0"

PYTHON_MODNAME="compressor"

# tests I think worked in the live ebuild fine.  It's tripping over a
# setting missing; COMPRESS_ROOT in compressor/conf.py
RESTRICT="test"
S=${WORKDIR}/${MY_PN}-${PV}

RDEPEND=""
DEPEND="${RDEPEND} >=dev-python/django-1.1.4
	dev-python/setuptools
	dev-python/django-appconf
	dev-python/versiontools
	test? ( dev-python/twill )"

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		local test
		for test in tests/tests/*.py
		do
			PYTHONPATH=. "$(PYTHON)" "${test}" || die "${test} failed with Python ${PYTHON_ABI}"
			einfo "Test "${test}" completed  OK"
		done
	}
	python_execute_function  testing
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml -r compressor/
	fi
}
