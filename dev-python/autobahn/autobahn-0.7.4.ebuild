# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/autobahn/autobahn-0.7.4.ebuild,v 1.2 2014/12/13 08:21:50 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="WebSocket and WAMP for Twisted and Asyncio"
HOMEPAGE="https://pypi.python.org/pypi/autobahn http://autobahn.ws/python/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# running on Twisted and asyncio,
# for python < 3.4
RDEPEND="
	dev-python/snappy
	dev-python/lz4
	dev-python/msgpack
	dev-python/twisted-core
	dev-python/ujson
	dev-python/wsaccel
	dev-python/zope-interface
	"
DEPEND="${RDEPEND}"
