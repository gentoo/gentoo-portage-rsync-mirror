# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-appconf/django-appconf-0.5.ebuild,v 1.2 2012/05/16 13:32:04 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="A helper class for handling configuration defaults of packaged apps gracefully"
HOMEPAGE="http://pypi.python.org/pypi/django-appconf http://django-appconf.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="BSD"
SLOT="0"

PYTHON_MODNAME="appconf"

RDEPEND=">=dev-python/django-1.1.4"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

src_compile() {
	if use doc; then
		emake -C docs pickle htmlhelp
	fi
	distutils_src_compile
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		pushd build-${PYTHON_ABI}/lib > /dev/null
		"$(PYTHON)" -m appconf.tests.tests
		popd > /dev/null
	}

	python_execute_function testing
}

src_install() {
	if use doc; then
		dohtml -r docs/_build

		insinto usr/share/doc/${PF}/html/doctrees
		doins -r docs/_build/doctrees/
	fi

	distutils_src_install
}
