# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jonpy/jonpy-0.10-r1.ebuild,v 1.1 2013/06/25 08:44:17 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Powerful multi-threaded object-oriented CGI/FastCGI/mod_python/html-templating facilities"
HOMEPAGE="http://jonpy.sourceforge.net/ http://pypi.python.org/pypi/jonpy"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""

python_install_all() {
	use doc && local HTML_DOCS=( doc/. )
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
