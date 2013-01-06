# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gnupg/python-gnupg-0.3.0.ebuild,v 1.1 2012/06/10 14:24:58 floppym Exp $

EAPI=4

inherit python-distutils-ng

DESCRIPTION="Python wrapper for GNU Privacy Guard"
HOMEPAGE="http://code.google.com/p/python-gnupg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="app-crypt/gnupg"

python_test() {
	"${PYTHON}" test_gnupg.py || die "Testing failed with ${PYTHON}"
}
