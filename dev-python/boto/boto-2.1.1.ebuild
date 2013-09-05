# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/boto/boto-2.1.1.ebuild,v 1.6 2013/09/05 18:46:27 mgorny Exp $

#please do not remove without checking if it is still required by
#sys-cluster/nova

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Amazon Web Services API"
HOMEPAGE="https://github.com/boto/boto http://pypi.python.org/pypi/boto"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/m2crypto )"
RDEPEND="dev-python/m2crypto"

# requires Amazon Web Services keys to pass some tests
RESTRICT="test"

python_test() {
	esetup.py test
}
