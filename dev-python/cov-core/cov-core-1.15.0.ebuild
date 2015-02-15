# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cov-core/cov-core-1.15.0.ebuild,v 1.2 2015/02/15 13:16:15 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )
inherit distutils-r1

DESCRIPTION="plugin core for use by pytest-cov, nose-cov and nose2-cov"
HOMEPAGE="https://bitbucket.org/memedough/cov-core/overview"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=dev-python/coverage-3.6[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
