# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hglib/hglib-0.3.ebuild,v 1.2 2013/01/23 16:20:50 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy{1_9,2_0} )
PYTHON_USE_WITH="threads"

MY_P="python-${P}"
MY_PN="python-${PN}"

inherit distutils-r1 eutils

DESCRIPTION="Library for using the Mercurial Command Server from Python"
HOMEPAGE="http://mercurial.selenic.com/"
SRC_URI="mirror://pypi/p/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-vcs/mercurial-1.9"
DEPEND="test? ( dev-python/nose )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	distutils-r1_src_prepare
	epatch "${FILESDIR}"/${P}-tests.patch
}

python_test() {
	${PYTHON} test.py
}
