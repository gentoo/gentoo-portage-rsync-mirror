# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-recaptcha/django-recaptcha-0.0.6-r2.ebuild,v 1.1 2013/06/01 15:49:15 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Django recaptcha form field/widget app"
HOMEPAGE="http://github.com/praekelt/django-recaptcha http://pypi.python.org/pypi/django-recaptcha"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/praekelt/${PN}/archive/0.0.6.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/django-setuptest-0.0.6[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Add missing source file rather than make our own
	cp -r "${FILESDIR}"/test_settings.py captcha || die
	local PATCHES=( "${FILESDIR}"/${PN}-fields.patch )
	distutils-r1_python_prepare_all
}

python_test() {
	# Use of nosetests gives confirmation that tests are run, "${PYTHON}" doesn't
	nosetests captcha/tests.py || die "Tests failed under ${EPYTHON}"
}
