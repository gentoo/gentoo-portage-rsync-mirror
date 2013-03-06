# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-recaptcha/django-recaptcha-0.0.6-r1.ebuild,v 1.1 2013/03/06 19:13:49 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} pypy{1_9,2_0} )
inherit distutils-r1 eutils

DESCRIPTION="Django recaptcha form field/widget app"
HOMEPAGE="http://github.com/praekelt/django-recaptcha http://pypi.python.org/pypi/django-recaptcha"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
		dev-python/setuptools
	test? ( >=dev-python/django-setuptest-0.0.6 )"

# set variables for testsuite
PATCHES=( "${FILESDIR}"/${PN}-fields.patch
	  "${FILESDIR}"/${PN}-settings.patch )

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	"${PYTHON}" captcha/tests.py && einfo "tests passed with ${PYTHON}" \
		|| die "Tests failed"
}
