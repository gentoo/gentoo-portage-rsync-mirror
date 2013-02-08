# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/argh/argh-0.23.0.ebuild,v 1.1 2013/02/08 09:08:59 patrick Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.5-jython"
PYTHON_MODNAME="argh"

inherit distutils eutils

DESCRIPTION="A simple argparse wrapper."
HOMEPAGE="http://packages.python.org/argh/"
SRC_URI="mirror://pypi/a/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-3"

RDEPEND=""
DEPEND=""
