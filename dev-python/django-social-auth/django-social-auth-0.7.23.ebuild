# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-social-auth/django-social-auth-0.7.23.ebuild,v 1.1 2013/05/28 15:55:52 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An easy to setup social authentication/authorization mechanism for Django projects"
HOMEPAGE="http://pypi.python.org/pypi/django-social-auth/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-python/django-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/oauth2-1.5.170[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY='green'
	local test
	for test in social_auth/tests/{base.py,client.py,facebook.py,google.py,odnoklassniki.py,twitter.py}
	do
		if ! "${PYTHON}" -c \
			"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" $test
		then
			die "test ${test} failed under ${EPYTHON}"
		else
			einfo "test ${test} passed"
		fi
	done
	einfo "All tests passed under ${EPYTHON}"
}
