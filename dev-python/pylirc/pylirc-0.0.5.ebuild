# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylirc/pylirc-0.0.5.ebuild,v 1.7 2010/07/23 22:34:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="lirc module for Python"
HOMEPAGE="http://sourceforge.net/projects/pylirc/ http://pypi.python.org/pypi/pylirc"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-misc/lirc"
RDEPEND="${DEPEND}"
