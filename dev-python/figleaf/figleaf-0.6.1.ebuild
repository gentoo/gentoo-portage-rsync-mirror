# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/figleaf/figleaf-0.6.1.ebuild,v 1.1 2012/08/27 10:54:06 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Code coverage tool"
HOMEPAGE="http://darcs.idyll.org/~t/projects/figleaf/doc/ http://pypi.python.org/pypi/figleaf"
SRC_URI="http://darcs.idyll.org/~t/projects/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="doc/*.txt doc/ChangeLog"
