# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyquery/pyquery-0.6.1.ebuild,v 1.4 2012/10/13 18:45:57 armin76 Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A jquery-like library for python"
HOMEPAGE="http://pypi.python.org/pypi/pyquery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~s390 ~sh ~x86"
IUSE=""

RDEPEND=">=dev-python/lxml-2.1"
DEPEND="${RDEPEND}"

DOCS="CHANGES.txt"
