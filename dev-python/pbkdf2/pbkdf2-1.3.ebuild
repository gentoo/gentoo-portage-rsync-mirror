# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pbkdf2/pbkdf2-1.3.ebuild,v 1.2 2015/03/05 16:08:55 mrueg Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Implementation of the password-based key derivation function, PBKDF2, specified in RSA PKCS#5 v2.0"
HOMEPAGE="http://www.dlitz.net/software/python-pbkdf2/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
