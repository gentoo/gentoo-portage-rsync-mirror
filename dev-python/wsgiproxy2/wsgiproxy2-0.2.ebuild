# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsgiproxy2/wsgiproxy2-0.2.ebuild,v 1.1 2013/06/03 05:53:03 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

# this looks quite unpossible to run
RESTRICT="test"

inherit distutils-r1

MY_PN="WSGIProxy2"

DESCRIPTION="HTTP proxying tools for WSGI apps"
HOMEPAGE="http://pythonpaste.org/wsgiproxy/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/urllib3
	dev-python/socketpool[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/restkit
	dev-python/webob[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/webtest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_PN}-${PV}"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
