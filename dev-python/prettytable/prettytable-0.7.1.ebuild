# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/prettytable/prettytable-0.7.1.ebuild,v 1.4 2014/03/02 22:17:49 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="A Python library for easily displaying tabular data in a
visually appealing ASCII table format."
HOMEPAGE="https://code.google.com/p/prettytable/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	"${PYTHON}" prettytable_test.py || die
}
