# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymtp/pymtp-0.0.4.ebuild,v 1.9 2012/05/24 03:08:48 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="LibMTP bindings for Python"
HOMEPAGE="http://libmtp.sourceforge.net/ http://pypi.python.org/pypi/PyMTP"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/libmtp-1.1.0"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="pymtp.py"
