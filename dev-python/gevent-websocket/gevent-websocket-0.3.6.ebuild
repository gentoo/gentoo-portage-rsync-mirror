# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent-websocket/gevent-websocket-0.3.6.ebuild,v 1.1 2012/08/27 13:46:14 ultrabug Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST=""

inherit distutils

MY_PN="gevent-websocket"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="Websocket handler for the gevent pywsgi server"
HOMEPAGE="http://pypi.python.org/pypi/gevent-websocket/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/gevent
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
