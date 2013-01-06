# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/biplist/biplist-0.5.ebuild,v 1.1 2012/06/28 06:11:53 patrick Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST=nosetests
inherit distutils

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="http://pypi.python.org/pypi/biplist/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/coverage
	dev-python/setuptools
	test? ( dev-python/nose
		dev-python/six )"
