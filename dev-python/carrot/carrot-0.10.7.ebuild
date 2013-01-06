# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/carrot/carrot-0.10.7.ebuild,v 1.1 2012/10/25 05:09:47 patrick Exp $

EAPI=3

PYTHON_DEPEND=2
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="AMQP Messaging Framework for Python"
HOMEPAGE="http://github.com/ask/carrot/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/anyjson
		>=dev-python/amqplib-0.6
		dev-python/setuptools"
RDEPEND="${DEPEND}"
