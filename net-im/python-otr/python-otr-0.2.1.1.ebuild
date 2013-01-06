# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/python-otr/python-otr-0.2.1.1.ebuild,v 1.3 2011/04/05 17:45:43 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python bindings for OTR encryption"
HOMEPAGE="http://pyotr.pentabarf.de/"
SRC_URI="http://pyotr.pentabarf.de/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="net-libs/libotr"
DEPEND="${RDEPEND}
	dev-lang/swig"

PYTHON_MODNAME="otr.py"
