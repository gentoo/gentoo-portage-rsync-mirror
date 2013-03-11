# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mox/mox-0.5.3-r1.ebuild,v 1.1 2013/03/11 00:34:05 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="A mock object framework for Python, loosely based on EasyMock for Java"
HOMEPAGE="http://code.google.com/p/pymox/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="test"

python_test() {
	${PYTHON} mox_test.py || die
}
