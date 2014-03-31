# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sure/sure-1.2.3.ebuild,v 1.3 2014/03/31 21:04:24 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A utility belt for automated testing in python for python"
HOMEPAGE="http://github.com/gabrielfalcao/sure"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="GPL-3"
SLOT="0"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
