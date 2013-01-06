# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2secret/m2secret-0.1.1.ebuild,v 1.3 2012/11/09 18:32:54 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Encryption and decryption module and CLI utility"
HOMEPAGE="http://www.heikkitoivonen.net/m2secret http://pypi.python.org/pypi/m2secret"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
	>=dev-python/m2crypto-0.18"
