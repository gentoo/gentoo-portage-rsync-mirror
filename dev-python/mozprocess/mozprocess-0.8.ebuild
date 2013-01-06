# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozprocess/mozprocess-0.8.ebuild,v 1.1 2012/10/30 07:08:28 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Mozilla-authored process handling"
HOMEPAGE="http://github.com/mozautomation/mozmill http://pypi.python.org/pypi/mozprocess"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/mozinfo"
DEPEND="${RDEPEND}
	dev-python/setuptools"
