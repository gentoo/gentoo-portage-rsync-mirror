# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/milk/milk-0.4.3.ebuild,v 1.1 2012/11/01 19:40:37 bicatali Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-pypy-* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Machine learning toolkit in Python"
HOMEPAGE="http://luispedro.org/software/milk"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="dev-python/numpy"
DEPEND="dev-python/setuptools
	test? ( dev-python/milksets sci-libs/scipy )"
