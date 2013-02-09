# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cdiff/cdiff-0.3.ebuild,v 1.1 2013/02/09 20:15:38 tomwij Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2} )
DOCS=( CHANGES README.rst )

inherit distutils-r1

DESCRIPTION="Colored, side-by-side diff terminal viewer."
HOMEPAGE="https://github.com/ymattw/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
