# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twython/twython-3.2.0.ebuild,v 1.2 2014/11/25 12:59:56 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="An easy (and up to date) way to access Twitter data with Python"
HOMEPAGE="https://github.com/ryanmcgrath/twython"
SRC_URI="mirror://pypi/t/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/requests-1.2.3[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.4.0[${PYTHON_USEDEP}]"
