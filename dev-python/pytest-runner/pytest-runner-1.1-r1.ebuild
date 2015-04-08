# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytest-runner/pytest-runner-1.1-r1.ebuild,v 1.5 2014/11/06 08:25:52 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Adds support for tests durring installation of setup.py files"
HOMEPAGE="http://pypi.python.org/pypi/pytest-runner"
SRC_URI="mirror://pypi/p/${PN}/${P}.zip"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/hgtools[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/pytest-runner.patch"
)
