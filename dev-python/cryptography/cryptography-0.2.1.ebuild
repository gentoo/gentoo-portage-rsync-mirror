# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cryptography/cryptography-0.2.1.ebuild,v 1.3 2014/03/01 05:06:34 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Library providing cryptographic recipes and primitives"
HOMEPAGE="https://github.com/pyca/cryptography/ https://pypi.python.org/pypi/cryptography/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-libs/openssl:0
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/cffi-0.8[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/iso8601[${PYTHON_USEDEP}]
		dev-python/pretend[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

DOCS=( AUTHORS.rst CONTRIBUTING.rst README.rst )

python_test() {
	"${PYTHON}" -m pytest --verbose tests || die "Tests fail with ${EPYTHON}"
}
