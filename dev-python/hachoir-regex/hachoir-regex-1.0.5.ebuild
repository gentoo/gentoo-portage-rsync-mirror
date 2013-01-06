# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hachoir-regex/hachoir-regex-1.0.5.ebuild,v 1.2 2010/10/30 20:41:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Manipulation of regular expressions (regex)"
HOMEPAGE="http://bitbucket.org/haypo/hachoir/wiki/hachoir-regex http://pypi.python.org/pypi/hachoir-regex"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DISTUTILS_GLOBAL_OPTIONS=("--setuptools")
PYTHON_MODNAME="${PN/-/_}"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_doc.py
	}
	python_execute_function testing
}
