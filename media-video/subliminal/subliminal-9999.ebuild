# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subliminal/subliminal-9999.ebuild,v 1.3 2014/03/14 15:02:03 maksbotan Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="Python library to search and download subtitles"
HOMEPAGE="http://subliminal.readthedocs.org https://github.com/Diaoul/subliminal https://pypi.python.org/pypi/subliminal"
EGIT_REPO_URI="https://github.com/Diaoul/subliminal.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-python/beautifulsoup-4.3.2:4[${PYTHON_USEDEP}]
	>=dev-python/guessit-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/enzyme-0.4[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.99[${PYTHON_USEDEP}]
	>=dev-python/dogpile-cache-0.5.2[${PYTHON_USEDEP}]
	>=dev-python/babelfish-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/charade-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/pysrt-0.5.0[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
# tests need network
RESTRICT="test"

python_test() {
	esetup.py test
}
