# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/txAMQP/txAMQP-0.6.1.ebuild,v 1.3 2013/08/03 09:45:39 mgorny Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
inherit distutils

DESCRIPTION="Python library for communicating with AMQP peers using Twisted"
HOMEPAGE="https://launchpad.net/txamqp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}
	dev-python/twisted-core"
