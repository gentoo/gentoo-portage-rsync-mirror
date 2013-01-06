# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/weberror/weberror-0.10.3.ebuild,v 1.1 2010/11/15 14:32:44 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="WebError"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Error handling and exception catching"
HOMEPAGE="http://pypi.python.org/pypi/WebError"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )
	>=dev-python/paste-1.7.1
	dev-python/pygments
	dev-python/setuptools
	dev-python/tempita
	dev-python/webob"
DEPEND="${RDEPEND}
	test? ( dev-python/webtest )"

S="${WORKDIR}/${MY_P}"
