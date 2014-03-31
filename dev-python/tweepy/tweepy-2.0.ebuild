# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tweepy/tweepy-2.0.ebuild,v 1.3 2014/03/31 21:17:18 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="A Python library for accessing the Twitter API "
HOMEPAGE="http://tweepy.github.com/"
SRC_URI="https://github.com/tweepy/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

DOCS="README.md"
RESTRICT="test" #fails all

python_test() {
	"${PYTHON}" -m tests || die "Tests failed"
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	dodoc ${DOCS}
	use doc && dohtml -r docs/_build/html/

	if use examples; then
		docinto examples
		dodoc examples/*
	fi
}
