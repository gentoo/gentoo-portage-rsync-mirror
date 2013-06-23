# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/edpwd/edpwd-0.0.4.ebuild,v 1.1 2013/06/23 16:46:38 tampakrap Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Encrypt/Decrypt Password Library that wraps up Blowfish"
HOMEPAGE="http://pypi.python.org/pypi/edpwdi/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pycrypto"

python_test() {
	if "${PYTHON}" -m edpwd.tests; then
		einfo "Test passed under ${EPYTHON}"
	else
		die "Test failed under ${EPYTHON}"
	fi
}
