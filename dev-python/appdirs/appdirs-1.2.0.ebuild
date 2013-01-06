# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/appdirs/appdirs-1.2.0.ebuild,v 1.1 2012/08/02 19:48:50 aidecoe Exp $

EAPI=4

inherit distutils

DESCRIPTION="Module for determining appropriate platform-specific dirs"
HOMEPAGE="http://github.com/ActiveState/appdirs"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
