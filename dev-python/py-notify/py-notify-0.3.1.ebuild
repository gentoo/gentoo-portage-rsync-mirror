# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-notify/py-notify-0.3.1.ebuild,v 1.2 2012/02/21 08:43:46 patrick Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit python distutils

DESCRIPTION="Tools for implementing the Observer programming pattern in Python"
HOMEPAGE="http://home.gna.org/py-notify"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
