# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/idna/idna-1.1.ebuild,v 1.1 2015/05/14 17:55:35 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} pypy )

inherit distutils-r1

DESCRIPTION="Internationalized Domain Names in Applications (IDNA)"
HOMEPAGE="https://github.com/kjd/idna"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

python_test() {
	esetup.py test
}
