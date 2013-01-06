# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyprof2calltree/pyprof2calltree-1.1.0.ebuild,v 1.2 2012/12/15 08:02:55 ulm Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="convert python profile data to kcachegrind calltree form"
HOMEPAGE="http://pypi.python.org/pypi/pyprof2calltree/"
SRC_URI="mirror://pypi/p/${PN}/${PF}.tar.gz"
IUSE=

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
