# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ecdsa/ecdsa-0.11-r2.ebuild,v 1.1 2015/01/29 12:44:57 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="ECDSA cryptographic signature library in pure Python"
HOMEPAGE="http://github.com/warner/python-ecdsa"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz -> ${P}-r1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~s390 ~sparc ~x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint"
IUSE=""

python_test() {
	esetup.py test
}
