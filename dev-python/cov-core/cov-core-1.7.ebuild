# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cov-core/cov-core-1.7.ebuild,v 1.3 2012/12/17 19:56:17 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_2 python3_3)
inherit distutils-r1

DESCRIPTION="plugin core for use by pytest-cov, nose-cov and nose2-cov"
HOMEPAGE="https://bitbucket.org/memedough/cov-core/overview"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]"
DEPEND=""
