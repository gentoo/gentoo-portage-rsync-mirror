# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cmd2/cmd2-0.6.4.ebuild,v 1.1 2013/01/26 08:01:43 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 )

inherit distutils-r1

DESCRIPTION="Extra features for standard library's cmd module"
HOMEPAGE="http://packages.python.org/cmd2/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
