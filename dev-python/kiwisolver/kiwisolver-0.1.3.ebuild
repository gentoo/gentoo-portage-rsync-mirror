# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kiwisolver/kiwisolver-0.1.3.ebuild,v 1.1 2014/11/15 13:00:40 idella4 Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="An efficient C++ implementation of the Cassowary constraint solving algorithm"
HOMEPAGE="https://github.com/nucleic/kiwi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="Clear-BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
		dev-python/setuptools[${PYTHON_USEDEP}]"
