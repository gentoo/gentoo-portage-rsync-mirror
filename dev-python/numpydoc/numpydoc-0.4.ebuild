# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/numpydoc/numpydoc-0.4.ebuild,v 1.1 2013/08/17 23:19:36 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Sphinx extension to support docstrings in Numpy format"
HOMEPAGE="https://pypi.python.org/pypi/numpydoc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~arm ~ppc ~ppc-macos ~ppc64 ~x64-macos ~x86 ~x86-freebsd ~x86-linux ~x86-macos"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
