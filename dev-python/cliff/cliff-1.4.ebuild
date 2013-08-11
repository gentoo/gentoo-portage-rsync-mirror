# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cliff/cliff-1.4.ebuild,v 1.1 2013/08/11 03:34:00 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 )

inherit distutils-r1

DESCRIPTION="Command Line Interface Formulation Framework"
HOMEPAGE="https://github.com/dreamhost/cliff"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6
		<dev-python/prettytable-0.8
		>=dev-python/cmd2-0.6.4[${PYTHON_USEDEP}]
		>=dev-python/pyparsing-1.5.7[${PYTHON_USEDEP}]"

python_prepare() {
	sed -i '29,37d' "setup.py" || die
}
