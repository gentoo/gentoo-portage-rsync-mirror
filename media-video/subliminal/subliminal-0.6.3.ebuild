# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subliminal/subliminal-0.6.3.ebuild,v 1.2 2014/07/06 12:53:48 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python library to search and download subtitles"
HOMEPAGE="http://subliminal.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/guessit-0.4.1[${PYTHON_USEDEP}]
	~dev-python/requests-0.14.2[${PYTHON_USEDEP}]
	>=dev-python/enzyme-0.1[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	rm -r tests/ || die

	distutils-r1_src_prepare
}
