# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-debug-toolbar/django-debug-toolbar-0.9.4.ebuild,v 1.2 2012/05/19 13:57:41 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A configurable set of panels that display debug information"
HOMEPAGE="http://pypi.python.org/pypi/django-debug-toolbar/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="MIT"
SLOT="0"
PYTHON_MODNAME="debug_toolbar"

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (	dev-python/dingus )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-with-py2.5.patch
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		PYTHONPATH=. "$(PYTHON)" -m tests.tests
		einfo "Tests for python$(python_get_version) completed"
		einfo ""
	}
	python_execute_function testing
}
