# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/edpwd/edpwd-0.0.7.ebuild,v 1.1 2013/06/27 22:19:41 tampakrap Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Encrypt/Decrypt Password Library that wraps up Blowfish"
HOMEPAGE="http://pypi.python.org/pypi/edpwd/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/setuptools-0.6.30[${PYTHON_USEDEP}]"
RDEPEND="dev-python/pycrypto[${PYTHON_USEDEP}]"

python_test() {
	set -- "${PYTHON}" setup.py test
	echo "${@}"
	"${@}" || die "Tests failed with ${EPYTHON}"
}
