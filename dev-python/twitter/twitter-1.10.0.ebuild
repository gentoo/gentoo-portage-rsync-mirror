# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twitter/twitter-1.10.0.ebuild,v 1.1 2013/06/25 07:48:14 patrick Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2} pypy{1_9,2_0} )

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
