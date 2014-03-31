# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twitter/twitter-1.9.2-r1.ebuild,v 1.3 2014/03/31 21:18:50 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="An API and command-line toolset for Twitter (twitter.com)"
HOMEPAGE="http://mike.verdone.ca/twitter/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
