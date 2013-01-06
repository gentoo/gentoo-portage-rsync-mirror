# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/assets/assets-0.1.1.ebuild,v 1.2 2011/10/30 16:43:38 maksbotan Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Cache-friendly asset management via content-hash-naming"
HOMEPAGE="http://jderose.fedorapeople.org/assets"
SRC_URI="http://jderose.fedorapeople.org/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
DOCS="README TODO AUTHORS"
