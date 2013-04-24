# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/guessit/guessit-9999.ebuild,v 1.1 2013/04/24 06:59:41 maksbotan Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1 git-2

DESCRIPTION="Python library that tries to extract as much information as possible from a filename"
HOMEPAGE="http://guessit.readthedocs.org/"
EGIT_REPO_URI="git://github.com/wackou/guessit.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-python/pyyaml[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_test() {
	esetup.py test
}
