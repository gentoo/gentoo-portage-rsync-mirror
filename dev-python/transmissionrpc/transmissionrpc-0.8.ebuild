# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/transmissionrpc/transmissionrpc-0.8.ebuild,v 1.1 2011/10/18 02:47:39 floppym Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

inherit distutils

DESCRIPTION="Python module that implements the Transmission bittorrent client RPC protocol"
HOMEPAGE="https://bitbucket.org/blueluna/transmissionrpc"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
