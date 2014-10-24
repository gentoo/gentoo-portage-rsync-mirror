# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pathtools/pathtools-0.1.2.ebuild,v 1.5 2014/10/24 02:34:24 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Pattern matching and various utilities for file systems paths"
HOMEPAGE="https://pypi.python.org/pypi/pathtools/"
SRC_URI="mirror://pypi/p/pathtools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
