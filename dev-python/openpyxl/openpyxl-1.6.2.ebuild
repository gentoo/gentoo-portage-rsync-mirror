# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/openpyxl/openpyxl-1.6.2.ebuild,v 1.4 2014/06/26 11:40:10 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Pure python reader and writer of Excel OpenXML files"
HOMEPAGE="http://bitbucket.org/ericgazoni/openpyxl/wiki/Home"
SRC_URI="https://bitbucket.org/ericgazoni/openpyxl/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_test() {
	# Testsuite appears py2 capable only
	! python_is_python3 && 	esetup.py test
}
