# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfeyn/pyfeyn-0.3.3.ebuild,v 1.2 2014/02/24 09:40:06 grozin Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python package for drawing Feynman diagrams"
HOMEPAGE="http://pyfeyn.hepforge.org/ https://pypi.python.org/pypi/pyfeyn/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyx[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-texlive/texlive-science"

PATCHES=( "${FILESDIR}"/${P}.patch )
