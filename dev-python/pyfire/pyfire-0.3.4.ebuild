# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfire/pyfire-0.3.4.ebuild,v 1.3 2013/08/03 09:45:50 mgorny Exp $

EAPI=4

DISTUTILS_SRC_TEST="setup.py"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.5 2.5-jython 3.*"

inherit distutils

DESCRIPTION="A python implementation of the Campfire API"
HOMEPAGE="http://www.pyfire.org/"

SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="
	dev-python/pyopenssl
	dev-python/twisted-core
"
