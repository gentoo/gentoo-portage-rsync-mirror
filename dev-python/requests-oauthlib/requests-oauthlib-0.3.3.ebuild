# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests-oauthlib/requests-oauthlib-0.3.3.ebuild,v 1.1 2013/08/24 07:36:49 ercpe Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1

DESCRIPTION="This project provides first-class OAuth library support for Requests"
HOMEPAGE="https://github.com/requests/requests-oauthlib"
SRC_URI="https://github.com/requests/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="ISC"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"
RDEPEND="
	>=dev-python/requests-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-0.4.2[${PYTHON_USEDEP}]
"

python_test() {
	esetup.py test
}