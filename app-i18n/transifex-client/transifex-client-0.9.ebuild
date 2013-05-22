# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/transifex-client/transifex-client-0.9.ebuild,v 1.1 2013/05/22 20:10:52 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="http://pypi.python.org/pypi/transifex-client http://www.transifex.net/"
SRC_URI="https://pypi.python.org/packages/source/t/transifex-client/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
