# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2secret/m2secret-0.1.1-r1.ebuild,v 1.4 2015/03/08 23:53:20 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Encryption and decryption module and CLI utility"
HOMEPAGE="http://www.heikkitoivonen.net/m2secret http://pypi.python.org/pypi/m2secret"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/m2crypto-0.18[${PYTHON_USEDEP}]"
