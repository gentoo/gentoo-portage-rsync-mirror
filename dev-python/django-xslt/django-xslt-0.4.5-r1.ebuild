# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-xslt/django-xslt-0.4.5-r1.ebuild,v 1.4 2015/03/08 23:45:36 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	test? ( http://dev.gentoo.org/~tampakrap/tarballs/${PN}-demoapp-0.4.5_p20120427.tar.bz2 )"

DESCRIPTION="an XSLT template system for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-xslt/"
KEYWORDS="amd64 x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/lxml[${PYTHON_USEDEP}] )"

python_test() {
	export SECRET_KEY="green"
	pushd "${WORKDIR}/demoapp" > /dev/null
	if ! "${PYTHON}" -c "from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" \
		manage.py test; then
		die "tests failed under ${EPYTHON}"
	else
		einfo "tests passed under ${EPYTHON}"
	fi
}
