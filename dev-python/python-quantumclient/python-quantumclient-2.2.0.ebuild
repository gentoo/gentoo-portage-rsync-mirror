# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-quantumclient/python-quantumclient-2.2.0.ebuild,v 1.1 2013/03/11 02:43:44 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Quantum API"
HOMEPAGE="https://launchpad.net/quantum"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/cliff-1.3.1
		dev-python/httplib2
		dev-python/iso8601
		>=dev-python/prettytable-0.6
		<dev-python/prettytable-0.7
		>=dev-python/pyparsing-1.5.6
		<dev-python/pyparsing-2.0
		dev-python/simplejson"
