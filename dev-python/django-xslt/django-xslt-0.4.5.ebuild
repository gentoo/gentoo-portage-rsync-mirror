# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-xslt/django-xslt-0.4.5.ebuild,v 1.1 2012/04/27 13:48:21 tampakrap Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
inherit distutils

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? ( http://dev.gentoo.org/~tampakrap/tarballs/${PN}-demoapp-0.4.5_p20120427.tar.bz2 )"

DESCRIPTION="A configurable set of panels that display debug information"
HOMEPAGE="http://pypi.python.org/pypi/django-xslt/"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"
PYTHON_MODNAME="djangoxslt"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/django
	dev-python/setuptools
	test? ( dev-python/lxml )"

src_test() {
	testing() {
		pushd "${WORKDIR}/demoapp" > /dev/null
		PYTHONPATH="${S}/build-${PYTHON_ABI}/lib/" \
			"$(PYTHON)" manage.py test
		popd "${WORKDIR}/demoapp" > /dev/null
	}
	python_execute_function testing
}
