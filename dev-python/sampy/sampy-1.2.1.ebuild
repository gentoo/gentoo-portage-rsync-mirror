# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sampy/sampy-1.2.1.ebuild,v 1.2 2014/06/15 00:34:56 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="tk(+)"

inherit distutils-r1

DESCRIPTION="Simple Application Messaging Protocol messaging system implementation in Python"
HOMEPAGE="http://packages.python.org/sampy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
