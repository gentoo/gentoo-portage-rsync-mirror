# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyacoustid/pyacoustid-1.0.0.ebuild,v 1.1 2013/06/08 14:54:22 sochotnicky Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python module for Chromaprint acoustic fingerprinting and the Acoustid API"
HOMEPAGE="http://pypi.python.org/pypi/pyacoustid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="media-libs/chromaprint
		dev-python/audioread[${PYTHON_USEDEP}]"
