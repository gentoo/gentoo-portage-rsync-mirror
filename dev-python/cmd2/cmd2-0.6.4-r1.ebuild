# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cmd2/cmd2-0.6.4-r1.ebuild,v 1.3 2015/04/08 08:05:16 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Extra features for standard library's cmd module"
HOMEPAGE="https://bitbucket.org/catherinedevlin/cmd2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyparsing[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m cmd2 -v || die "Tests fail with ${EPYTHON}"
}
