# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mimeparse/mimeparse-0.1.3-r1.ebuild,v 1.6 2013/05/03 19:56:07 pinkbyte Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Basic functions for handling mime-types in python"
HOMEPAGE="http://code.google.com/p/mimeparse"
SRC_URI="http://mimeparse.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( virtual/python-json[${PYTHON_USEDEP}] )"

# tests fail for python3
python_test() {
	"${PYTHON}" mimeparse_test.py || die
}
