# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyquery/pyquery-1.2.1.ebuild,v 1.8 2012/10/13 18:45:57 armin76 Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.1 *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST=nosetests

inherit distutils

DESCRIPTION="A jquery-like library for python"
HOMEPAGE="http://pypi.python.org/pypi/pyquery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-python/lxml-2.1
	dev-python/cssselect
	>=dev-python/webob-1.2_rc1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES.txt README.txt"
