# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/turses/turses-0.2.13-r1.ebuild,v 1.2 2014/08/05 18:34:08 mrueg Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Command line twitter client"
HOMEPAGE="https://github.com/alejandrogomez/turses"
SRC_URI="https://github.com/alejandrogomez/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/oauth2[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]
	>dev-python/tweepy-2.2[${PYTHON_USEDEP}]
	<dev-python/tweepy-3[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/tox[${PYTHON_USEDEP}]
	)
"

python_compile_all() {
	if use doc; then
		emake -C docs html
		dodoc -r "docs/_build/html" || die
	fi
	
	emake -C docs man
	doman "docs/_build/man/turses.1" || die
}

python_test() {
	py.test tests || die "Tests fail with ${EPYTHON}"
}
