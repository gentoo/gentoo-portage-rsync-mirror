# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scoop/scoop-0.7.0-r1.ebuild,v 1.1 2014/02/25 12:32:31 slis Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Distributed Evolutionary Algorithms in Python"
HOMEPAGE="https://code.google.com/p/scoop/ http://pypi.python.org/pypi/scoop"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.release.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/greenlet-0.3.4
	>=dev-python/pyzmq-13.1.0
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${P}.release"
