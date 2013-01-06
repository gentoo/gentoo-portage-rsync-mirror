# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/transifex-client/transifex-client-0.8.0.ebuild,v 1.3 2012/08/04 20:41:01 johu Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="http://pypi.python.org/pypi/transifex-client http://www.transifex.net/"
SRC_URI="http://github.com/transifex/transifex-client/tarball/0.8 -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

# Upstream is using a very weird naming scheme
GITHUB_HASH="b001295"
S="${WORKDIR}"/${PN/transifex/transifex-transifex}-${GITHUB_HASH}
