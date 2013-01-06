# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gitdb/gitdb-0.5.4.ebuild,v 1.2 2011/08/27 20:57:27 neurogeek Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="GitDB is a pure-Python git object database"
HOMEPAGE="https://github.com/gitpython-developers/gitdb
	http://pypi.python.org/pypi/gitdb"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-vcs/git"
DEPEND="${RDEPEND}
	dev-python/setuptools
	>=dev-python/async-0.6
	>=dev-python/smmap-0.8"
RESTRICT_PYTHON_ABIS="3.*"
