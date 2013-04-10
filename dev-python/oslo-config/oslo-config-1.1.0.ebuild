# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oslo-config/oslo-config-1.1.0.ebuild,v 1.1 2013/04/10 16:04:44 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="The Oslo configuration API supports parsing command line arguments
and ini style configuration files"
HOMEPAGE="https://pypi.python.org/pypi/oslo.config"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.config/oslo.config-${PV}.tar.gz"
S="${WORKDIR}/oslo.config-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#need to package a bunch of stuff, they changed their test suite, again...
RESTRICT="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]"
