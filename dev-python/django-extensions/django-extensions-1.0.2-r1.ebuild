# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-extensions/django-extensions-1.0.2-r1.ebuild,v 1.1 2013/05/22 07:48:57 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

GIT_HASH_TAG="48fa7dd"

DESCRIPTION="Django Command Extensions"
HOMEPAGE="http://github.com/django-extensions/django-extensions http://code.google.com/p/django-command-extensions/"
SRC_URI="http://github.com/django-extensions/django-extensions/tarball/${PV}/${P}.tgz"

LICENSE="BSD || ( MIT GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc graphviz mysql postgres s3 sqlite vcard"

RDEPEND="dev-python/django[mysql?,postgres?,sqlite?]
	dev-python/pygments
	dev-python/werkzeug
	graphviz? ( dev-python/pygraphviz )
	s3? ( dev-python/boto )
	vcard? ( dev-python/vobject )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${PN}-${PN}-${GIT_HASH_TAG}"

DOCS=( docs/AUTHORS README.rst )

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	"${PYTHON}" run_tests.py || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
