# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyRSS2Gen/PyRSS2Gen-1.0.0-r1.ebuild,v 1.2 2013/09/05 18:46:11 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="RSS feed generator written in Python"
HOMEPAGE="http://www.dalkescientific.com/Python/PyRSS2Gen.html http://pypi.python.org/pypi/PyRSS2Gen"
SRC_URI="http://www.dalkescientific.com/Python/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
