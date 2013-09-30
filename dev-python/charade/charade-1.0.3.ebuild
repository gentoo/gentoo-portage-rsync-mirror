# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/charade/charade-1.0.3.ebuild,v 1.7 2013/09/30 17:17:27 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Universal encoding detector for python 2 and 3 (fork of chardet)"
HOMEPAGE="https://github.com/sigmavirus24/charade/ http://pypi.python.org/pypi/charade/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
