# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rsa/rsa-3.1.1.ebuild,v 1.4 2012/08/19 18:48:44 johu Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Pure-Python RSA implementation"
HOMEPAGE="http://stuvel.eu/rsa http://pypi.python.org/pypi/rsa"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=">=dev-python/pyasn1-0.0.13
	>=dev-python/setuptools-0.6.10"
DEPEND="${RDEPEND}"
