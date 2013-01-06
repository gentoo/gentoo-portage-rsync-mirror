# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent-socketio/gevent-socketio-0.3.5_rc2.ebuild,v 1.1 2012/08/27 13:52:49 ultrabug Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST=""

inherit distutils

MY_PN="gevent-socketio"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="SocketIO server based on the Gevent pywsgi server"
HOMEPAGE="http://pypi.python.org/pypi/gevent-socketio/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gevent-websocket"
DEPEND="${RDEPEND}
	dev-python/gevent
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
