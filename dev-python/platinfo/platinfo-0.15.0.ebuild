# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/platinfo/platinfo-0.15.0.ebuild,v 1.6 2013/07/06 16:05:39 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Determines and returns consistent names for platforms"
HOMEPAGE="http://code.google.com/p/platinfo/"
SRC_URI="http://platinfo.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
