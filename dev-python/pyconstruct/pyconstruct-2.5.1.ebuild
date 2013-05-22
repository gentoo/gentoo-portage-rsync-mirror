# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyconstruct/pyconstruct-2.5.1.ebuild,v 1.1 2013/05/22 07:28:51 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils eutils

MY_PN="construct"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A powerful declarative parser for binary data"
HOMEPAGE="http://construct.wikispaces.com/ http://pypi.python.org/pypi/construct"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/six"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="construct"
