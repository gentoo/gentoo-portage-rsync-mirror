# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traceback2/traceback2-1.4.0.ebuild,v 1.4 2015/04/05 14:02:09 alunduil Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_3 python3_4 )

inherit distutils-r1

DESCRIPTION="Backports of the traceback module"
HOMEPAGE="https://github.com/testing-cabal/traceback2"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
"
RDEPEND="dev-python/linecache2[${PYTHON_USEDEP}]"
