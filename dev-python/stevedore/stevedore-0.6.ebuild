# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stevedore/stevedore-0.6.ebuild,v 1.1 2012/11/05 08:49:33 patrick Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 *-jython 2.7-pypy-*"

inherit distutils python

DESCRIPTION="Manage dynamic plugins for Python applications"
HOMEPAGE="https://github.com/dreamhost/stevedore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
