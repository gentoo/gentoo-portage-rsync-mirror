# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/slowaes/slowaes-0.1-r1.ebuild,v 1.3 2014/06/24 11:49:53 blueness Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_P=${P}a1
DESCRIPTION="AES implementation in pure Python"
HOMEPAGE="http://code.google.com/p/slowaes/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPENDS="dev-python/setuptools"

S=${WORKDIR}/${MY_P}
