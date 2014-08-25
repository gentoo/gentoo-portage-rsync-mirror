# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/crumbs/crumbs-9999.ebuild,v 1.1 2014/08/25 00:02:51 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 python3_3 )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/alunduil/crumbs.git"

DESCRIPTION="Generalized all-in-one parameters module"
HOMEPAGE="https://github.com/alunduil/crumbs"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="inotify test"

DEPEND="
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
RDEPEND="inotify? ( dev-python/pyinotify[${PYTHON_USEDEP}] )"

python_test() {
	flake8 || die 'flake8'
	nosetests || die 'nosetests'
}
