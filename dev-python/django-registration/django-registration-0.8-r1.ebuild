# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-registration/django-registration-0.8-r1.ebuild,v 1.1 2013/05/27 14:27:49 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An extensible user-registration application for Django"
HOMEPAGE="http://www.bitbucket.org/ubernostrum/django-registration/wiki/ http://pypi.python.org/pypi/django-registration"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/django[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	export SECRET_KEY='green'
	local test
	for test in registration/tests/{backends.py,forms.py,models.py,urls.py,views.py}
	do
		if ! "${PYTHON}" -c \
			"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" ${test}
		then
			die "test ${test} failed under ${EPYTHON}"
		else
			einfo "test ${test} passed"
		fi
	done
	einfo "tests passed under ${EPYTHON}"
}
