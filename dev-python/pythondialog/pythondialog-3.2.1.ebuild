# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythondialog/pythondialog-3.2.1.ebuild,v 1.1 2014/12/15 14:40:23 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} pypy3 )

inherit distutils-r1

DESCRIPTION="A Python module for making simple text/console-mode user interfaces"
HOMEPAGE="http://pythondialog.sourceforge.net/"
SRC_URI="mirror://sourceforge/pythondialog//${PV}/python3-${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc examples"

DEPEND="dev-util/dialog
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

python_prepare_all() {
	sed -e "/^    'sphinx.ext.intersphinx',/d" -i doc/conf.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	use doc && local HTML_DOCS=( doc/_build/html/. )

	distutils-r1_python_install_all
}
