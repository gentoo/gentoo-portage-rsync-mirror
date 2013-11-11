# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbolift/turbolift-2.0.3.ebuild,v 1.2 2013/11/10 23:11:36 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="Openstack Swift sync/backup utility"
HOMEPAGE="https://github.com/cloudnull/turbolift/wiki"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

RDEPEND="dev-python/prettytable[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"
