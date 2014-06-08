# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pretend/pretend-1.0.7.ebuild,v 1.8 2014/06/08 11:06:05 hattya Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A library for stubbing in Python"
HOMEPAGE="https://github.com/alex/pretend/ https://pypi.python.org/pypi/pretend/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
