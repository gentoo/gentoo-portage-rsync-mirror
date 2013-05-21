# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-endless-pagination/django-endless-pagination-1.1-r1.ebuild,v 1.1 2013/05/21 15:51:10 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Tools supporting ajax, multiple and lazy pagination, Twitter-style and Digg-style pagination"
HOMEPAGE="http://code.google.com/p/django-endless-pagination/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=">=dev-python/django-1.3[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	export SECRET_KEY='green'
	if ! "${PYTHON}" -c \
		"from django.conf import global_settings;global_settings.SECRET_KEY='$SECRET_KEY'" \
		-d tests/runtests.py; then
		die "Tests failed under python2.7"
	else
		einfo "Tests passed under python2.7"
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( "${S}"/doc/_build/html/. )

	#rm all OSX fork files, Bug #450842
	pushd "${ED}" > /dev/null
	rm -f $(find . -name "._*")
	distutils-r1_python_install_all
}
