# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/waitress/waitress-0.8.9.ebuild,v 1.2 2014/05/21 05:45:44 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A pure-Python WSGI server"
HOMEPAGE="http://docs.pylonsproject.org/projects/waitress/en/latest/ https://pypi.python.org/pypi/waitress/ https://github.com/Pylons/waitress"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz \
		doc? ( http://dev.gentoo.org/~idella4/pylons_sphinx_theme.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/nose )"

python_prepare_all() {
	if use doc; then
		local PATCHES=( "${FILESDIR}"/${P}-doc.patch )
		einfo "doc patch applied"
		mv "${WORKDIR}"/_themes ./docs/ || die
	fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
