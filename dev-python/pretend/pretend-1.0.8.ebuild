# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pretend/pretend-1.0.8.ebuild,v 1.2 2014/04/20 06:36:01 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="A library for stubbing in Python"
HOMEPAGE="https://github.com/alex/pretend/ https://pypi.python.org/pypi/pretend/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
