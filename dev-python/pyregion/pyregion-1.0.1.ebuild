# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyregion/pyregion-1.0.1.ebuild,v 1.4 2012/02/23 20:20:14 mr_bones_ Exp $

EAPI=2

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Python module to parse ds9 region file"
HOMEPAGE="http://leejjoon.github.com/pyregion/"
SRC_URI="http://github.com/downloads/leejjoon/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}"
