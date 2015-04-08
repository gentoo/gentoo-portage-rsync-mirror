# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsmin/jsmin-2.0.3.ebuild,v 1.3 2014/03/31 20:32:05 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="JavaScript minifier"
HOMEPAGE="https://bitbucket.org/dcs/jsmin/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc"
LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	pushd "${BUILD_DIR}"/lib > /dev/null
	"${PYTHON}" -m ${PN}.test || die
}
