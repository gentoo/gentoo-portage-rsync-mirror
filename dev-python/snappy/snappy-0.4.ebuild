# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/snappy/snappy-0.4.ebuild,v 1.1 2012/04/19 09:54:11 patrick Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

inherit distutils

DESCRIPTION="Python library for the snappy compression library from Google"
HOMEPAGE="http://pypi.python.org/pypi/python-snappy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=app-arch/snappy-1.0.2"
DEPEND=""

S="${WORKDIR}/${MY_P}"
