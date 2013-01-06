# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/embedly/embedly-0.4.3.ebuild,v 1.1 2012/05/15 01:20:59 rafaelmartins Exp $

EAPI=4
DISTUTILS_SRC_TEST="nosetests"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

MY_PN="Embedly"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python Library for Embedly"
HOMEPAGE="https://github.com/embedly/embedly-python/ http://pypi.python.org/pypi/Embedly"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
	dev-python/httplib2
	dev-python/simplejson"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
