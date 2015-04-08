# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-international/django-international-0.0.3.ebuild,v 1.3 2013/09/05 18:47:07 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )
inherit distutils-r1

DESCRIPTION="Country and currency data for Django projects"
HOMEPAGE="http://pypi.python.org/pypi/django-international https://bitbucket.org/monwara/django-international"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_python_install_all
	dodir usr/share/doc/${P}/fixtures
	docompress -x usr/share/doc/${P}/fixtures
	insinto usr/share/doc/${P}/fixtures
	doins international/fixtures/countries_fixture.json
}
