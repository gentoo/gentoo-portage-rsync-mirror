# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sh/sh-1.08.ebuild,v 1.4 2014/02/08 11:03:30 jlec Exp $

EAPI=5

PYTHON_COMPAT=(python{2_{6,7},3_{2,3}})

inherit distutils-r1

DESCRIPTION="Python subprocess interface"
HOMEPAGE="https://github.com/amoffat/sh"
SRC_URI="https://github.com/amoffat/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]"
python_test() {
	${PYTHON} test.py || die
}
