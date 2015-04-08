# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/weberror/weberror-0.10.3-r1.ebuild,v 1.1 2014/11/29 23:55:46 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="WebError"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Error handling and exception catching"
HOMEPAGE="http://pypi.python.org/pypi/WebError"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/paste-1.7.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/tempita[${PYTHON_USEDEP}]
	dev-python/webob[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/webtest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}
