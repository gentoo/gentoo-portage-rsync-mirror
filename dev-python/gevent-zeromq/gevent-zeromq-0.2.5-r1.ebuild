# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gevent-zeromq/gevent-zeromq-0.2.5-r1.ebuild,v 1.4 2015/03/08 23:49:13 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

MY_PN="gevent_zeromq"
MY_P="${MY_PN}-${PV/_/-}"

DESCRIPTION="Gevent compatibility layer for pyzmq"
HOMEPAGE="http://pypi.python.org/pypi/gevent_zeromq/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="~dev-python/pyzmq-2.2.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
