# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycountry/pycountry-0.14.5.ebuild,v 1.1 2012/09/16 05:25:39 radhermit Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="ISO country, subdivision, language, currency and script definitions and their translations"
HOMEPAGE="http://pypi.python.org/pypi/pycountry"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-python/setuptools"

DOCS="HISTORY.txt TODO.txt"
