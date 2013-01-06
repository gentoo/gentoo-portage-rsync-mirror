# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cl/cl-0.0.3.ebuild,v 1.2 2012/05/30 14:27:15 mr_bones_ Exp $

EAPI="4"
PYTHON_DEPEND="*:2.5"
RESTRICT_PYTHON_ABIS="2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Actor framework for Kombu"
HOMEPAGE="https://github.com/ask/cl http://pypi.python.org/pypi/cl"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/kombu-1.3.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

# Tests are configured in setup.py but missing
RESTRICT="test"
