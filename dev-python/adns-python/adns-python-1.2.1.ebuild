# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/adns-python/adns-python-1.2.1.ebuild,v 1.13 2012/02/21 08:06:21 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python bindings for ADNS"
HOMEPAGE="http://code.google.com/p/adns-python/ http://pypi.python.org/pypi/adns-python"
SRC_URI="http://adns-python.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/adns-1.3"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="ADNS.py DNSBL.py"
