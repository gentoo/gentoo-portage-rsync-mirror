# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/w3lib/w3lib-1.2.ebuild,v 1.1 2012/06/28 07:46:40 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python library of web-related functions"
HOMEPAGE="http://github.com/scrapy/w3lib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
