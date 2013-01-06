# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-celery/django-celery-3.0.11.ebuild,v 1.1 2012/10/25 10:59:48 iksaif Exp $

EAPI="4"
PYTHON_COMPAT="python2_7"

inherit python-distutils-ng

DESCRIPTION="Celery Integration for Django"
HOMEPAGE="http://celeryproject.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/celery-3.0.11
	>=dev-python/django-1.3
	dev-python/pytz"
DEPEND="${RDEPEND}
	test? (
		>=dev-python/unittest2-0.4.0
		dev-python/django-nose
		dev-python/nose-cover3
		dev-python/python-memcached
	)
	dev-python/setuptools"

python_test() {
	${PYTHON} setup.py test
}
