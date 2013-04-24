# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subliminal/subliminal-9999.ebuild,v 1.1 2013/04/24 07:14:12 maksbotan Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 git-2

DESCRIPTION="Python library to search and download subtitles"
HOMEPAGE="http://subliminal.readthedocs.org/"
EGIT_REPO_URI="git://github.com/Diaoul/subliminal.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/guessit-0.4.1[${PYTHON_USEDEP}]
	~dev-python/requests-0.14.2[${PYTHON_USEDEP}]
	>=dev-python/enzyme-0.1[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	rm -r tests/ || die

	distutils-r1_src_prepare
}
