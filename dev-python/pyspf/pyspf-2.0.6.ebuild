# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyspf/pyspf-2.0.6.ebuild,v 1.3 2012/05/09 03:20:55 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="Python implementation of the Sender Policy Framework (SPF) protocol"
HOMEPAGE="http://pypi.python.org/pypi/pyspf"
SRC_URI="mirror://sourceforge/pymilter/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( dev-python/pydns:2 dev-python/pydns:0 )"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="spf.py"
