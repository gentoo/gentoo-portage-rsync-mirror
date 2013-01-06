# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytest-cov/pytest-cov-1.6.ebuild,v 1.3 2012/12/17 19:59:56 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_2 python3_3)
inherit distutils-r1

DESCRIPTION="py.test plugin for coverage reporting"
HOMEPAGE="http://bitbucket.org/memedough/pytest-cov/overview"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/cov-core[${PYTHON_USEDEP}]"
