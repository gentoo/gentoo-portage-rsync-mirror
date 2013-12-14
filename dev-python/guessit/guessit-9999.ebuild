# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guessit/guessit-9999.ebuild,v 1.2 2013/12/14 15:27:01 tomwij Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3} )
EGIT_REPO_URI="https://github.com/wackou/guessit.git"

inherit distutils-r1 git-2

DESCRIPTION="Library for guessing information from video files"
HOMEPAGE="http://guessit.readthedocs.org https://github.com/wackou/guessit https://pypi.python.org/pypi/guessit"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	>=dev-python/babelfish-0.4.1[${PYTHON_USEDEP}]
	dev-python/stevedore[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_test() {
	esetup.py nosetests
}
